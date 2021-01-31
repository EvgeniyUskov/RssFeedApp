//
//  SourcePreenterTests.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import XCTest
@testable import RSSFeedApp

class SourcePresenterTests: XCTestCase {
    var interactor: SourceInteractorProtocol?
    var sourceViewController: SourceViewControllerStub?
    var presenter: SourcePresenter?
    
    var networkManager: NetworkManagerProtocol?
    var storageManager: SourceStorageProtocol?
    
    var sourceViewModel: SourceViewModel?
    
    override func setUpWithError() throws {
        networkManager = NetworkManagerStub()
        storageManager = StorageManagerStub()
        
        if let storageManager = storageManager {
            let source = storageManager.createSource()
            source.title = "Foo \(1)"
            source.url = "www.foobar.com/rss\(1)"
            source.checked = true
            
            sourceViewModel = SourceViewModel(source: source)
        }
        if let sourceViewModel = sourceViewModel {
            sourceViewController = SourceViewControllerStub(viewModel: sourceViewModel)
            if let sourceViewController = sourceViewController {
                presenter = SourcePresenter(viewController: sourceViewController)
            }
        }
        
        guard let presenterLocal = presenter, let storageManager = storageManager else {return}
        interactor = SourceInteractorStub(presenter: presenterLocal,
                                          storageManager: storageManager)
    }
    
    override func tearDownWithError() throws {
    }
    
    func testPresentData() throws {
        if let source = self.sourceViewModel?.source {
            interactor?.saveSource(with: source, completionHandler: {
                [weak self] in
                XCTAssertNotNil( self?.sourceViewController?.viewModel?.source, "Source must not be nil")
                
                if let source = self?.sourceViewController?.viewModel?.source {
                    XCTAssertEqual(source.title, "Foo 1", "wrong title")
                    XCTAssertEqual(source.url, "www.foobar.com/rss1", "wrong url")
                }
            })
        }
    }
    
}
