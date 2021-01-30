//
//  SettingsPresenter.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import Foundation

//MARK: Protocols
public protocol SettingsPresenterProtocol: AnyObject {
    func presentData(with sources: [RssSource])
}

//MARK: Settings prsenter
public class SettingsPresenter {
    //MARK: Properties
    weak var viewController: SettingsViewControllerProtocol?
    
    //MARK: Init methods
    public init(viewController: SettingsViewControllerProtocol) {
        self.viewController = viewController
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    public func presentData(with sources: [RssSource]) {
        let sourceViewModels = sources.map {
            SourceViewModel(source: $0)
        }
        viewController?.displayData(with: sourceViewModels)
    }
}
