//
//  ListIntercator.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import Foundation
@testable import RSSFeedApp

public class ListInteractorStub {
    //MARK: Properties
    var presenter: ListPresenterProtocol?

    private var networkManager: NetworkManagerProtocol?
    private var storageManager: SourceStorageProtocol?
    
    //MARK: Init metods
    public init(presenter: ListPresenterProtocol, networkManager: NetworkManagerProtocol, storageManager: SourceStorageProtocol) {
        self.presenter = presenter
        self.networkManager = networkManager
        self.storageManager = storageManager
    }
    
}

//MARK: SearchInteractorProtocol implementation methods
extension ListInteractorStub: ListInteractorProtocol{
    public func fetchFeed() {
        networkManager?.fetchFeed(forUrls: Set<URL>(), completionHandler: {
            [weak self]
            news, _ in
            self?.presenter?.presentData(with: news.array)
        })
    }
}
