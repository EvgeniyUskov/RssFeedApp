//
//  SettingsPresenter.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import Foundation

//MARK: Protocols
public protocol SettingsPresenterProtocol: AnyObject {
    
}

//MARK: Settings prsenter
public class SettingsPresenter: SettingsPresenterProtocol {
    //MARK: Properties
    weak var viewController: SettingsViewControllerProtocol?
    
    //MARK: Init methods
    public init(viewController: SettingsViewControllerProtocol) {
        self.viewController = viewController
    }
}
