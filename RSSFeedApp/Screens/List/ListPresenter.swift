//
//  ListViewPresenter.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import Foundation

//MARK: Protocols
public protocol ListPresenterProtocol: AnyObject {
    
}

public class ListPresenter {
    //MARK: Properties
    weak var viewController: ListViewControllerProtocol?
    
    //MARK: Init
    public init(viewController: ListViewControllerProtocol) {
        self.viewController = viewController
    }
    
}

//MARK: ListPresenterProtocol Implementation
extension ListPresenter: ListPresenterProtocol {
    
}
