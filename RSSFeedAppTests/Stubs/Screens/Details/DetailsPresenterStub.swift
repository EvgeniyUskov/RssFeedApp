//
//  DetailsPresenterTests.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//


import Foundation
import FeedKit

@testable import RSSFeedApp

public class DetailsPresenterStub {
    public var news: [NewsViewModel]?
}

extension DetailsPresenterStub: DetailsPresenterProtocol {
    
}
