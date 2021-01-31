//
//  SourceInteractorTests.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import XCTest
@testable import RSSFeedApp

class SourceInteractorTests: XCTestCase {
    
    var interactor: SourceInteractor?
    var presenter: SourcePresenterStub?
    var storageManager: SourceStorageProtocol?
    var viewController: SourceViewController?
    var sourceViewModel: SourceViewModel?
    var source: RssSource?
    
    override func setUpWithError() throws {
        viewController = SourceViewController()
        storageManager = StorageManagerStub()
        
        if let storageManager = storageManager {
            self.source = storageManager.createSource()
            
            source?.title = "Foo \(1)"
            source?.url = "www.foobar.com/rss\(1)"
            if let sourceLocal = source {
                sourceViewModel = SourceViewModel(source: sourceLocal)
            }
        }
        
        if let viewController = viewController, let viewModel = sourceViewModel {
            presenter = SourcePresenterStub(viewController: viewController)
            
            let settingsViewController = SourceViewControllerStub(viewModel: viewModel)
            guard let presenterLocal = presenter, let storageManager = storageManager else {return}
            interactor = SourceInteractor(presenter: presenterLocal,
                                          storageManager: storageManager)
            presenter?.interactor = interactor
            presenter?.viewController = settingsViewController
        }
    }
    
    override func tearDownWithError() throws {
    }
    
    public func testInteractorLoadNews() throws {
        if let source = source {
            interactor?.saveSource(with: source, completionHandler: {
                [weak self] in
                XCTAssertNotNil(self?.presenter?.viewModel?.source, "Source must not be nil")
                XCTAssertEqual(self?.presenter?.viewModel?.title, "Foo 1")
                XCTAssertEqual(self?.presenter?.viewModel?.url, "https://www.foobar.com/rss1")
            })
        }
    }
}
