//
//  NetworkManagerStub.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import Foundation
import FeedKit
@testable import RSSFeedApp

public class NetworkManagerStub: NetworkManagerProtocol {
    public func fetchFeed(forUrls urls: Set<URL>, completionHandler: @escaping (ThreadsafeArray<RSSFeedItem>, ThreadsafeArray<URL>) -> ()) {
        let array = ThreadsafeArray<RSSFeedItem>()
        let errURLArray = ThreadsafeArray<URL>()
        
        for i in 1 ... 5 {
            let item = RSSFeedItem()
            item.title = "Foo \(i)"
            item.description = "Bar \(i)"
            item.pubDate = Date()
            array.append(item)
        }
        
        for i in 1 ... 5 {
            let item = URL(string: "https://www.foobar.com/rss\(i)")
            if let url = item {
                errURLArray.append(url)
            }
        }
        
        completionHandler(array, errURLArray)
    }
    
}
