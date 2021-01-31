//
//  SettingsInteractorTests.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import XCTest
@testable import RSSFeedApp

class SettingsInteractorTests: XCTestCase {

        var interactor: SettingsInteractor?
        var presenter: SettingsPresenterStub?
        var storageManager: SourceStorageProtocol?
            
        override func setUpWithError() throws {
            storageManager = StorageManagerStub()
            presenter = SettingsPresenterStub()
            
            let settingsViewController = SettingsViewControllerStub()
            guard let presenterLocal = presenter, let storageManager = storageManager else {return}
            interactor = SettingsInteractor(presenter: presenterLocal,
                                        storageManager: storageManager)
            presenter?.interactor = interactor
            presenter?.viewController = settingsViewController
        }
        
        override func tearDownWithError() throws {
        }
        
        public func testInteractorLoadSources() throws {
            interactor?.loadSources(completionHandler: {
                [weak self] in
                XCTAssertNotNil(self?.presenter?.sourceViewModels, "No sources received")
                XCTAssertEqual(self?.presenter?.sourceViewModels?.count, 5, "Wrong number of sources received")
                XCTAssertEqual(self?.presenter?.sourceViewModels?[0].title, "Foo 1")
                XCTAssertEqual(self?.presenter?.sourceViewModels?[0].url, "https://www.foobar.com/rss1")
            })
        }
    }
