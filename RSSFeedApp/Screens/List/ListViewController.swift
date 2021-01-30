//
//  NewsListViewController.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import UIKit
import FeedKit

//MARK: Protocols
public protocol ListViewControllerProtocol: AnyObject {
    func displayData(viewModel: ListViewModel)
    func displayAlert(alert: UIAlertController)
}

public protocol ListViewControllerRoutingProtocol: AnyObject {
    func showDetails(with detailsViewController: DetailsViewController)
    func showSettings(with settingsViewController: SettingsViewController)
}

//MARK: ListViewController
public class ListViewController: UITableViewController {
    //MARK: Views
    lazy var pullToRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshRSSFeed(sender:)), for: .valueChanged)
        refreshControl.tintColor = Constants.Colors.textColor
        //refreshControl.attributedTitle = NSAttributedString(string: "Обновляем вашу ленту...", attributes: nil)
        return refreshControl
    }()
    
    lazy var loadingView: LoadingView = {
        return LoadingView()
    }()
    
    //MARK: Properties
    var presenter: ListPresenter?
    var interactor: ListInteractor?
    var router: ListRouter?
    
    var viewModel = ListViewModel(news: [])
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        fetchFeed()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        fetchFeed()
    }
    
}

// MARK: - Table View Delegate Data Source implementation methods
extension ListViewController {
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.news.count == 0 {
            self.tableView.setEmptyView(title: Constants.Stuff.noNewsTitleMessage, message: Constants.Stuff.noNewsSubtitleMessage)
        } else {
            self.tableView.restore()
        }
        
        return viewModel.news.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reusableCell(forIndexPath: indexPath)
        cell.configure(with: viewModel.news[indexPath.row])
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! NewsCell
        cell.markAsViewed()
        router?.navigateToDetails(with: viewModel.news[indexPath.row])
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    private func reusableCell(forIndexPath indexPath: IndexPath) -> NewsCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Ids.newsCellReuseId, for: indexPath) as! NewsCell
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

//MARK: ListViewControllerProtocol
extension ListViewController: ListViewControllerProtocol {
    public func displayData(viewModel: ListViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.pullToRefreshControl.endRefreshing()
            self.loadingView.hideLoading()
        }
    }
    
    public func displayAlert(alert: UIAlertController) {
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

//MARK: ListViewControllerRoutingProtocol implememtation Navigation
extension ListViewController: ListViewControllerRoutingProtocol {
    public func showSettings(with settingsViewController: SettingsViewController) {
        navigationController?.pushFromLeft(viewController: settingsViewController)
    }
    
    public func showDetails(with detailsViewController: DetailsViewController) {
        self.show(detailsViewController, sender: self)
    }
}

//MARK: Additional methods
extension ListViewController {
    //MARK: Setup methods
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBar.getAppearance()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.barTintColor = Constants.Colors.backgroundColor
        navigationController?.navigationBar.tintColor = Constants.Colors.textColor
        navigationItem.title = "Новости"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.lefthalf.fill")?.withRenderingMode(.alwaysTemplate) , style: .plain, target: self, action: #selector(openSettings))
        self.navigationItem.leftBarButtonItem?.tintColor = Constants.Colors.textColor
    }
    
    private func setupTableView() {
        tableView.register(NewsCell.self, forCellReuseIdentifier: Constants.Ids.newsCellReuseId)
        tableView.refreshControl = pullToRefreshControl
    }
    
    @objc
    private func openSettings() {
        router?.navigateToSettings()
    }
    
    @objc
    private func refreshRSSFeed(sender: UIRefreshControl) {
        fetchFeed()
    }
    
    private func fetchFeed() {
        loadingView.showLoading()
        interactor?.fetchFeed()
    }
    
}
