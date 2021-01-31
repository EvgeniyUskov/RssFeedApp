//
//  SourceInteractorStub.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import Foundation
@testable import RSSFeedApp

public class SourceInteractorStub {
    
    //MARK: Properties
    weak var presenter: SourcePresenterProtocol?
    var storageManager: SourceStorageProtocol?
    
    //MARK: Init
    public init(presenter: SourcePresenterProtocol, storageManager: SourceStorageProtocol) {
        self.presenter = presenter
        self.storageManager = storageManager
    }
    
    //MARK: Additional methods
    public func createRssSource() {
        if let rssSource = storageManager?.createSource() {
            presenter?.presentData(with: rssSource)
        }
    }
}

//MARK: SourceInteractorProtocol implementation
extension SourceInteractorStub: SourceInteractorProtocol {
    public func saveSource(with source: RssSource, completionHandler: @escaping () -> () ) {
        storageManager?.addSource(with: source, completionHandler: {
            [weak self] in
            self?.presenter?.presentData(with: source)
            completionHandler()
        })
    }
}

