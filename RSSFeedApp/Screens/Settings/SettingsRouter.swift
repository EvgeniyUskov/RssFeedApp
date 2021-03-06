//
//  SettingsRouter.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import UIKit

//MARK: Protocols
public protocol SettingsRouterProtocol {
    func navigateToSourceDetails(with viewModel: SourceViewModel?)
}

public class SettingsRouter {
    //MARK: Properties
    weak var viewController: (SettingsViewControllerRoutingProtocol & SettingsUpdatingDelegate)?
    
    //MARK: Init
    public init (viewController: SettingsViewControllerRoutingProtocol & SettingsUpdatingDelegate) {
        self.viewController = viewController
    }
}

//MARK: SettingsRouterProtocol Implementation
extension SettingsRouter: SettingsRouterProtocol {
    public func navigateToSourceDetails(with viewModel: SourceViewModel?) {
        guard let viewController = viewController else { return }
        let sourceViewController = SourceBuilder().build(with: viewModel, settingsUpdateDelegate: viewController )
        viewController.showDetails(with: sourceViewController)
    }
    

}
