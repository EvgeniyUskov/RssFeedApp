//
//  SettingsViewController.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import UIKit

//MARK: Protocols
public protocol SettingsViewControllerProtocol: AnyObject {
    func displayData(with sources: [SourceViewModel])
}

public protocol SettingsViewControllerRoutingProtocol: AnyObject {
    func showDetails(with viewController: SourceViewController)
}

public protocol SettingsTableActionDelegate {
    func deleteItem(at indexPath: IndexPath)
}

//MARK: SettingsViewController
public class SettingsViewController: SwipeTableViewController {
    
    //MARK: Views
    let searchController = UISearchController(searchResultsController: nil)
    lazy var loadingView: LoadingView = {
        return LoadingView()
    }()
    
    //MARK: Properties
    var presenter: SettingsPresenterProtocol?
    var interactor: SettingsInteractor?
    var router: SettingsRouter?
    
    var viewModel = SettingsViewModel(sources: [])
    
    private var timer : Timer?
    
    //MARK: View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupSearchBar()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingView.showLoading()
        loadSources()
    }
    
    //MARK: updateModel implementation
    public override func updateModel(at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.deleteData(viewModel: self.viewModel.sources[indexPath.row], completionHandler: {
            [weak self] in
            self?.viewModel.sources.remove(at: indexPath.row)
            DispatchQueue.main.async {
                [weak self] in
                self?.tableView.reloadData()
            }
        })
    }
}

//MARK: UITableViewDelegate UITableViewDataSource methods
extension SettingsViewController {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.sources.count == 0 {
            self.tableView.setEmptyView(title: Constants.Stuff.noSourcesTitleMessage, message: Constants.Stuff.noSourcesSubtitleMessage)
        } else {
            self.tableView.restore()
        }
        return viewModel.sources.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let switchView: UISwitch = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! SourceCell
        cell.configure(with: self.viewModel.sources[indexPath.row])
        switchView.setOn(viewModel.sources[indexPath.row].checked, animated: true)
        cell.accessoryView = switchView
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showEditSourceDetailsView(for: viewModel.sources[indexPath.row])
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    private func reusableCell(forIndexPath indexPath: IndexPath) -> SourceCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Ids.settingsCellReuseId, for: indexPath) as! SourceCell
        return cell
    }
    
}

//MARK: SettingsViewControllerProtocol Implementation
extension SettingsViewController: SettingsViewControllerProtocol {
    public func displayData(with sources: [SourceViewModel]) {
        self.viewModel.sources = sources
        self.tableView.reloadData()
        loadingView.hideLoading()
    }
}

//MARK: SettingsViewControllerProtocol Implementation
extension SettingsViewController: SettingsViewControllerRoutingProtocol {
    public func showDetails(with viewController: SourceViewController) {
        self.showDetailViewController(viewController, sender: self)
    }
}
//MARK: SettingsUpdating delegate implementation
extension SettingsViewController: SettingsUpdatingDelegate {
    public func didAddNewSource() {
        loadSources()
    }
}

//MARK: SearchBarDeegate Implementation
extension SettingsViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchTerm: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.interactor?.showSources(with: searchTerm)
        })
    }
}

//MARK: Additional methods
extension SettingsViewController {
    private func loadSources() {
        interactor?.loadSources()
    }

    private func showEditSourceDetailsView(for viewModel: SourceViewModel) {
        router?.navigateToSourceDetails(with: viewModel)
    }
    
    //MARK: Action methods
    @objc
    private func closeSettings() {
        navigationController?.popFromLeft()
    }
    
    @objc
    private func showAddSourceDetailsView() {
        router?.navigateToSourceDetails(with: nil)
    }
    
    @objc
    func switchChanged(_ sender : UISwitch!){
        viewModel.sources[sender.tag].checked = sender.isOn
        viewModel.sources[sender.tag].source.checked = sender.isOn
        interactor?.saveSources()
    }
    
    //MARK: Setup
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate) , style: .plain, target: self, action: #selector(showAddSourceDetailsView))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.Stuff.rightBarButtonItemText, style: .plain, target: self, action: #selector(closeSettings) )
    }
    
    private func setupTableView() {
        tableView.register(SourceCell.self, forCellReuseIdentifier: Constants.Ids.settingsCellReuseId)
        tableView.backgroundColor = Constants.Colors.backgroundColor
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = Constants.Stuff.sourcesPlaceHolder
        UIHelper.setupSearchBarUI(searchBar: searchController.searchBar)
    }
}

