//
//  SourceRouter.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 28.01.2021.
//

import Foundation
import UIKit

//MARK: Protocols
public protocol SourceRouterProtocol {
    
}

public class SourceRouter: SourceRouterProtocol {
    
    //MARK: Properties
    weak var viewController: SourceViewControllerRoutingProtocol?
    
    //MARK: Init
    public init (viewController: SourceViewControllerRoutingProtocol) {
        self.viewController = viewController
    }
}
