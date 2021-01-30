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

//MARK: SettingsViewController
public class SettingsViewController: UITableViewController {
    
    //MARK: Views
    
    //MARK: Properties
    var presenter: SettingsPresenterProtocol?
    var interactor: SettingsInteractor?
    var router: SettingsRouter?
    
    var viewModel = SettingsViewModel(sources: [])
    
    //MARK: View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSources()
    }
}

//MARK: UITableViewDelegate UITableViewDataSource methods
extension SettingsViewController {
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
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
        
        let cell = reusableCell(forIndexPath: indexPath)
        cell.configure(with: viewModel.sources[indexPath.row])
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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

//MARK: Additional methods
extension SettingsViewController {
    
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
    
    private func showEditSourceDetailsView(for viewModel: SourceViewModel) {
        router?.navigateToSourceDetails(with: viewModel)
    }
    
    //MARK: Setup
    private func loadSources() {
        interactor?.loadSources()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate) , style: .plain, target: self, action: #selector(showAddSourceDetailsView))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.Stuff.rightBarButtonItemText, style: .plain, target: self, action: #selector(closeSettings) )
    }
    
    private func setupTableView() {
        tableView.register(SourceCell.self, forCellReuseIdentifier: Constants.Ids.settingsCellReuseId)
    }
}

