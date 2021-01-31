//
//  ListViewControllerStub.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import UIKit
@testable import RSSFeedApp

//MARK: ListViewControllerStub
public class ListViewControllerStub: UIViewController {
    
    //MARK: Properties
    var viewModel = ListViewModel(news: [])
    
    public var router: ListRouterProtocol?
    public var interactor: ListInteractorProtocol?
    public var presenter: ListPresenterProtocol?
    
    init(viewModel: ListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: UISearchBarDelegate implementation methods
extension ListViewControllerStub: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchTerm: String) {
        interactor?.fetchFeed()
    }
}

//MARK: ListViewControllerProtocol implementation protocols
extension ListViewControllerStub: ListViewControllerProtocol {
    public func displayAlert(alert: UIAlertController) {
        
    }
    
    public func displayData(viewModel listViewModel: ListViewModel) {
        self.viewModel = listViewModel
    }
}

//MARK: ListViewControllerRoutingProtocol implementation protocols
extension ListViewControllerStub: ListViewControllerRoutingProtocol {
    public func showSettings(with settingsViewController: SettingsViewController) {
        navigationController?.pushFromLeft(viewController: settingsViewController)
    }
    
    public func showDetails(with detailsViewController: DetailsViewController) {
        self.show(detailsViewController, sender: self)
    }
}
