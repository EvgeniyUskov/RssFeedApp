//
//  ListRouter.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import UIKit

//MARK: Protocols
public protocol ListRouterProtocol {
    func navigateToDetails(with viewModel: NewsViewModel)
    func navigateToSettings()
}

//MARK: ListRouter
public class ListRouter {
    weak var viewController: ListViewControllerRoutingProtocol?
    
    init(viewController: ListViewControllerRoutingProtocol) {
        self.viewController = viewController
    }
}

//ListRouterProtocol implementation
extension ListRouter: ListRouterProtocol {
    public func navigateToDetails(with viewModel: NewsViewModel) {
        let detailsViewController = DetailsBuilder().build(with: viewModel)
        viewController?.showDetails(with: detailsViewController)
    }
    
    public func navigateToSettings() {
        let settingsViewController = SettingsBuilder().build()
        viewController?.showSettings(with: settingsViewController)
    }
}
