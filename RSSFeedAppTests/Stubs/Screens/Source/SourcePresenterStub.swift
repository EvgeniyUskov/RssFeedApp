//
//  SourcePresenterStub.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import Foundation

@testable import RSSFeedApp

public class SourcePresenterStub {
    //MARK: Properties
    weak var viewController: SourceViewControllerProtocol?
    var interactor: SourceInteractorProtocol?

    var viewModel: SourceViewModel?
    
    //MARK: Init methods
    public init(viewController: SourceViewControllerProtocol) {
        self.viewController = viewController
    }
}

//MARK: SourcePresenterProtocol Implementation
extension SourcePresenterStub: SourcePresenterProtocol {
    public func presentData(with source: RssSource) {
        viewModel = SourceViewModel(source: source)
        guard let viewModel = viewModel else { return }
        viewController?.displayData(with: viewModel)
    }
    
    public func saveSource(with viewModel: SourceViewModel, completionHandler: @escaping () -> ()) {
        interactor?.saveSource(with: viewModel.source, completionHandler: {
            completionHandler()
        })
    }
}
