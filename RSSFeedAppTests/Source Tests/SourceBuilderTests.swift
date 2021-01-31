//
//  SourceBuilderTests.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import XCTest
@testable import RSSFeedApp

class SourceBuilderTests: XCTestCase {
    var sourceViewModel: SourceViewModel?
    var settingsUpdatingdelegate: SettingsViewController?
    
    override func setUpWithError() throws {
        let storageManager = StorageManagerStub()
        settingsUpdatingdelegate = SettingsViewController()
        
        let source = storageManager.createSource()
        source.title = "Foo \(1)"
        source.url = "www.foobar.com/rss\(1)"
        sourceViewModel = SourceViewModel(source: source)
    }
    
    override func tearDownWithError() throws {
    
    }

    func testSourceBuilder() throws {
        if let settingsUpdatingdelegate = settingsUpdatingdelegate {
            let vc = SourceBuilder().build(with: sourceViewModel, settingsUpdateDelegate: settingsUpdatingdelegate)
            
            XCTAssertNotNil(vc.presenter, "presenter must not be nil")
            XCTAssertNotNil(vc.interactor, "interactor must not be nil")
            XCTAssertNotNil(vc.router, "router must not be nil")
            XCTAssertNotNil(vc.viewModel, "viewModel must not be nil")
        }
    }

}
