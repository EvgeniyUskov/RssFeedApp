//
//  ListPresenter.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//


import Foundation
import FeedKit

@testable import RSSFeedApp

public class ListPresenterStub {
    public var news: [NewsViewModel]?
}

extension ListPresenterStub: ListPresenterProtocol {
    public func presentData(with feedItems: [RSSFeedItem]) {
        news = [NewsViewModel]()
        for item in feedItems {
            news?.append(NewsViewModel(pubDate: item.pubDate, title: item.title, text: item.description))
        }
        
    }
    
    public func presentAlert(alert: UIAlertController) {
    }
}
