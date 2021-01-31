//
//  SettingsPresenterTests.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import XCTest
@testable import RSSFeedApp

class SettingsPresenterTests: XCTestCase {
    var interactor: SettingsInteractorProtocol?
    var settingsViewController: SettingsViewControllerStub?
    var presenter: SettingsPresenter?
    var networkManager: NetworkManagerProtocol?
    var storageManager: SourceStorageProtocol?
    
    override func setUpWithError() throws {
        
        settingsViewController = SettingsViewControllerStub()
        networkManager = NetworkManagerStub()
        storageManager = StorageManagerStub()
        presenter = SettingsPresenter(viewController: settingsViewController!)
        
        guard let presenterLocal = presenter, let networkManager = networkManager, let storageManager = storageManager else {return}
        interactor = SettingsInteractorStub(presenter: presenterLocal,
                                        networkManager: networkManager,
                                        storageManager: storageManager)
    }
    
    override func tearDownWithError() throws {
    }
    
    func testPresentData() throws {
        interactor?.loadSources(completionHandler: {
            [weak self] in
            XCTAssertNotNil(self?.settingsViewController?.viewModel.sources, "No sources received")
            XCTAssertEqual(self?.settingsViewController?.viewModel.sources.count, 5, "Wrong number of sources received")
            XCTAssertEqual(self?.settingsViewController?.viewModel.sources[0].title, "Foo 5")
            XCTAssertEqual(self?.settingsViewController?.viewModel.sources[0].url, "https://www.foobar.com/rss5")
        })
    }
    
}
