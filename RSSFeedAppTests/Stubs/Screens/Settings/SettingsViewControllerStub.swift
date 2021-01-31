//
//  SettingsViewControllerStub.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import Foundation


import UIKit
@testable import RSSFeedApp

//MARK: ListViewControllerStub
public class SettingsViewControllerStub: UIViewController {
    
    //MARK: Properties
    var viewModel = SettingsViewModel(sources: [])
    
    public var router: ListRouterProtocol?
    public var interactor: ListInteractorProtocol?
    public var presenter: ListPresenterProtocol?
    
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: ListViewControllerProtocol implementation protocols
extension SettingsViewControllerStub: SettingsViewControllerProtocol {
    public func displayData(with sources: [SourceViewModel]) {
        self.viewModel.sources = sources
    }
}

//MARK: ListViewControllerRoutingProtocol implementation protocols
//extension ListViewControllerStub: SettingsViewControllerRoutingProtocol {
//    public func showSettings(with settingsViewController: SettingsViewController) {
//    }
//    
//    public func showDetails(with detailsViewController: DetailsViewController) {
//    }
//}
