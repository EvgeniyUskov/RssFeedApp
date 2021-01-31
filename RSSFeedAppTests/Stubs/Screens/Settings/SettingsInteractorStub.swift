//
//  SettingsInteractorStub.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import Foundation
@testable import RSSFeedApp

public class SettingsInteractorStub {
    //MARK: Properties
    var presenter: SettingsPresenterProtocol?
    
    private var networkManager: NetworkManagerProtocol?
    private var storageManager: SourceStorageProtocol?
    
    //MARK: Init metods
    public init(presenter: SettingsPresenterProtocol, networkManager: NetworkManagerProtocol, storageManager: SourceStorageProtocol) {
        self.presenter = presenter
        self.networkManager = networkManager
        self.storageManager = storageManager
    }
    
}

//MARK: SearchInteractorProtocol implementation methods
extension SettingsInteractorStub: SettingsInteractorProtocol{
    public func loadSources(completionHandler: @escaping () -> ()) {
        storageManager?.loadSources(sources: .allSources, searchTerm: nil, completionHandler: {
            [weak self]
            (sources) in
            DispatchQueue.main.async {
                [weak self] in
                if !sources.isEmpty {
                    self?.presenter?.presentData(with: sources)
                }
                completionHandler()
            }
        })
    }
    
    public func saveSources() {
        storageManager?.saveSources(completionHandler: {})
    }
    
    public func deleteData(source: RssSource, completionHandler: @escaping () -> () ) {
        storageManager?.deleteSource(source: source, completionHandler: {
            completionHandler()
        })
    }
    
    public func showSources(with searchTerm: String) {
        storageManager?.loadSources(with: searchTerm, completionHandler: { (sources) in
            DispatchQueue.main.async {
                [weak self] in
                if !sources.isEmpty {
                    self?.presenter?.presentData(with: sources)
                }
            }
        })
    }
    
    
}

