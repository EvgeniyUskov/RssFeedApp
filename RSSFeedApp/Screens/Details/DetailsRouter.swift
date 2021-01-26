//
//  DetailsRouter.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import UIKit

//MARK: Protocols
public protocol DetailsRouterProtocol {
    
}

//MARK: DetailsRouter
public class DetailsRouter {
    weak var viewController: DetailsViewControllerRoutingProtocol?
    
    init(viewController: DetailsViewControllerRoutingProtocol) {
        self.viewController = viewController
    }
}

//MARK: DetailsRouterProtocol Implmeetation
extension DetailsRouter: DetailsRouterProtocol {
    
}
