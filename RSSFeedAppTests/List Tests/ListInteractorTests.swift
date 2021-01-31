//
//  ListInteractorTests.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import XCTest
@testable import RSSFeedApp

class ListInteractorTests: XCTestCase {

    var interactor: ListInteractor?
    var presenter: ListPresenterStub?
    var networkManager: NetworkManagerProtocol?
    var storageManager: SourceStorageProtocol?
        
    override func setUpWithError() throws {
        networkManager = NetworkManagerStub()
        storageManager = StorageManagerStub()
        presenter = ListPresenterStub()
        
        guard let presenterLocal = presenter, let networkManager = networkManager, let storageManager = storageManager else {return}
        interactor = ListInteractor(presenter: presenterLocal,
                                    storageManager: storageManager,
                                    networkManager: networkManager)
    }
    
    override func tearDownWithError() throws {
    }
    
    public func testInteractorLoadNews() throws {
        interactor?.fetchFeed()
        
        XCTAssertNotNil(presenter?.news, "No news received")
        XCTAssertEqual(presenter?.news?.count, 5, "Wrong number of newss received")
        XCTAssertEqual(presenter?.news?[0].title, "Foo 1")
        XCTAssertEqual(presenter?.news?[0].text, "Bar 1")
    }
}
