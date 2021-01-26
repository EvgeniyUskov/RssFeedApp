//
//  SettingsRouter.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import UIKit

//MARK: Protocols
public protocol SettingsRouterProtocol {
    
}

public class SettingsRouter: SettingsRouterProtocol {
    weak var viewController: SettingsViewControllerRoutingProtocol?
    
    public init (viewController: SettingsViewControllerRoutingProtocol) {
        self.viewController = viewController
    }
}
