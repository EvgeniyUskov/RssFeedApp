//
//  NetworkManager.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import Foundation
import FeedKit

//MARK: Protocols
public protocol NetworkManagerProtocol {
    func fetchFeed(forUrls urls: Set<URL>, completionHandler: @escaping (ThreadsafeArray<RSSFeedItem>, ThreadsafeArray<URL>) -> () )
}

//MARK: NetworkManager
public class NetworkManager: NetworkManagerProtocol {
    
    public func fetchFeed(forUrls urls: Set<URL>, completionHandler: @escaping (ThreadsafeArray<RSSFeedItem>, ThreadsafeArray<URL>) -> () ) {
        let feedItems = ThreadsafeArray<RSSFeedItem>()
        let errorUrls = ThreadsafeArray<URL>()
        let feedFetchersWorkGroup = DispatchGroup()
        
        for url in urls {
            DispatchQueue.global(qos: .default).async(group: feedFetchersWorkGroup) {
                let parser = FeedParser(URL: url)
                
                let result = parser.parse()
                
                switch result {
                case .success(let feed):
                    let rssFeed = feed.rssFeed
                    guard let items = rssFeed?.items else {return}
                    feedItems.append(contentsOf: items)
                case .failure( _):
                    errorUrls.append(url)
                }
            }
        }
        
        feedFetchersWorkGroup.notify(queue: DispatchQueue.main) {
            completionHandler(feedItems, errorUrls)
        }
    }
}

