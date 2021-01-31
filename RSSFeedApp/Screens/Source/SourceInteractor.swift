//
//  SourceInteractor.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 28.01.2021.
//

import Foundation
import UIKit

//MARK: Protocols
public protocol SourceInteractorProtocol {
    func saveSource(with viewModel: RssSource, completionHandler: @escaping () -> ())
}

//MARK: SourceInteractor
public class SourceInteractor {
    
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
extension SourceInteractor: SourceInteractorProtocol {
    public func saveSource(with source: RssSource, completionHandler: @escaping () -> () ) {
        storageManager?.addSource(with: source, completionHandler: {
            completionHandler()
        })
    }
}
