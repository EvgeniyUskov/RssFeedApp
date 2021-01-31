//
//  SettingsPresenter.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import Foundation


import FeedKit
@testable import RSSFeedApp

public class SettingsPresenterStub {
    //MARK: Properties
    weak var viewController: SettingsViewControllerProtocol?
    var interactor: SettingsInteractor?
    
    var sourceViewModels: [SourceViewModel]?
    
}

extension SettingsPresenterStub: SettingsPresenterProtocol {
    public func deleteData(viewModel: SourceViewModel, completionHandler: @escaping () -> () ) {
        interactor?.deleteData(source: viewModel.source, completionHandler: {
            completionHandler()
        })
    }
    
    public func presentData(with sources: [RssSource]) {
        sourceViewModels = sources.map {
            SourceViewModel(source: $0)
        }
        if let sourceViewModels = sourceViewModels {
            viewController?.displayData(with: sourceViewModels)
        }
    }
    
}
