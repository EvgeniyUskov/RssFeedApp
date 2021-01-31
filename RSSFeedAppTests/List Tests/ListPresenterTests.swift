//
//  ListPresenterTests.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import XCTest
@testable import RSSFeedApp

    class ListPresenterTests: XCTestCase {
        var interactor: ListInteractorProtocol?
        var listViewController: ListViewControllerStub?
        var presenter: ListPresenter?
        var networkManager: NetworkManagerProtocol?
        var storageManager: SourceStorageProtocol?
            
        override func setUpWithError() throws {
            let viewModel = ListViewModel(news: [])
            listViewController = ListViewControllerStub(viewModel: viewModel)
            networkManager = NetworkManagerStub()
            storageManager = StorageManagerStub()
            presenter = ListPresenter(viewController: listViewController!)
            
            guard let presenterLocal = presenter, let networkManager = networkManager, let storageManager = storageManager else {return}
            interactor = ListInteractorStub(presenter: presenterLocal,
                                          networkManager: networkManager,
                                          storageManager: storageManager)
        }
        
        override func tearDownWithError() throws {
        }

        func testPresentData() throws {
            interactor?.fetchFeed()
            
            XCTAssertNotNil(listViewController?.viewModel.news, "No news received")
            XCTAssertEqual(listViewController?.viewModel.news.count, 5, "Wrong number of newss received")
            XCTAssertEqual(listViewController?.viewModel.news[0].title, "Foo 5")
            XCTAssertEqual(listViewController?.viewModel.news[0].text, "Bar 5")
        }

    }
