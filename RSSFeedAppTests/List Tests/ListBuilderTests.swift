//
//  ListTests.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import XCTest
@testable import RSSFeedApp

class ListBuilderTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
    
    }

    func testListBuilder() throws {
        let vc = ListBuilder().build()
        
        XCTAssertNotNil(vc.presenter, "presenter must not be nil")
        XCTAssertNotNil(vc.interactor, "interactor must not be nil")
        XCTAssertNotNil(vc.router, "router must not be nil")
        XCTAssertNotNil(vc.viewModel, "viewModel must not be nil")
    }
    
    func testViewController() throws {
        
    }

}
