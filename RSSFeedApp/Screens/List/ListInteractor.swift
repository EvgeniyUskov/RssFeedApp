//
//  ListViewControllerInteractor.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import Foundation
import FeedKit

//MARK: Protocols
public protocol ListInteractorProtocol: AnyObject {
    func fetchFeed()
}

//MARK: ListInteractor
public class ListInteractor {
    //MARK: Properties
    weak var presenter: ListPresenterProtocol?
    var storageManager: SourceStorageProtocol?
    var networkManager: NetworkManagerProtocol?
    
    var feedUrls = Set<URL>()
    
    //MARK: Init
    public init(presenter: ListPresenter?, storageManager: SourceStorageProtocol, networkManager: NetworkManagerProtocol) {
        self.presenter = presenter
        self.storageManager = storageManager
        self.networkManager = networkManager
        
    }
}

//MARK: ListInteractorProtocol implementation
extension ListInteractor: ListInteractorProtocol {
    public func fetchFeed() {
        storageManager?.loadSources(sources: .activeSources, searchTerm: nil ,completionHandler: {
            [weak self]
            sources in
            self?.feedUrls = Set(sources.compactMap {
                URL(string: $0.url ?? "")
            })
            
            if let feedUrls = self?.feedUrls {
                self?.networkManager?.fetchFeed(forUrls: feedUrls, completion: {
                    [weak self]
                    items, errorUrls in
                    self?.presenter?.presentData(with: items.array)
                    if !errorUrls.isEmpty {
                        var errorUrlsString = ""
                        for url in errorUrls.array {
                            errorUrlsString += url.absoluteString + "\n"
                        }
                        let alert = UIAlertController(title: Constants.Stuff.wrongRss, message: errorUrlsString, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self?.presenter?.presentAlert(alert: alert)
                    }
                })
            }
        })
        
    }
    
}
