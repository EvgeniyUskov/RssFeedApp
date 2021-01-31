//
//  DetailsBuilderTests.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import XCTest
import FeedKit
@testable import RSSFeedApp

class DetailsBuilderTests: XCTestCase {

    var newsViewModel: NewsViewModel?
    
    override func setUpWithError() throws {
        newsViewModel = NewsViewModel()
        newsViewModel?.title = "Foo \(1)"
        newsViewModel?.text = "Bar \(1)"
        newsViewModel?.pubDate = Date()
    }

    override func tearDownWithError() throws {
    }

    func testDetailsBuilder() throws {
        guard let viewModel = newsViewModel else { return }
        let vc = DetailsBuilder().build(with: viewModel)
        
        XCTAssertNotNil(vc.presenter, "presenter must not be nil")
        XCTAssertNotNil(vc.interactor, "interactor must not be nil")
        XCTAssertNotNil(vc.router, "router must not be nil")
        XCTAssertNotNil(vc.viewModel, "viewModel must not be nil")
    }

}
