//
//  DetailsPresenter.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import Foundation

//MARK: Protocols
public protocol DetailsPresenterProtocol: AnyObject {
    
}

public class DetailsPresenter {
    //MARK: Properties
    weak var viewController: DetailsViewControllerProtocol?
    
    //MARK: Init
    public init(viewController: DetailsViewControllerProtocol) {
        self.viewController = viewController
    }
    
}

//MARK: DetailsPresenterProtocol Implementation
extension DetailsPresenter: DetailsPresenterProtocol {
    
}
