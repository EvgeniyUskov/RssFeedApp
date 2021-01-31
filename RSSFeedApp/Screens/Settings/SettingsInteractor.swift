//
//  SettingsInteractor.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import UIKit

//MARK: Protocols
public protocol SettingsInteractorProtocol {
    func loadSources()
    func saveSources()
    
    func showSources(with searchTerm: String)
    func deleteData(source: RssSource, completionHandler: @escaping () -> () )
}

//MARK: SettingsInteractor
public class SettingsInteractor {
    var presenter: SettingsPresenterProtocol?
    var storageManager: SourceStorageProtocol?
    
    public init(presenter: SettingsPresenterProtocol, storageManager: SourceStorageProtocol) {
        self.presenter = presenter
        self.storageManager = storageManager
    }
}

//MARK: SettingsInteractorProtocol implementation
extension SettingsInteractor: SettingsInteractorProtocol {
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
    
    public func loadSources() {
        storageManager?.loadSources(sources: .allSources, searchTerm: nil, completionHandler: {
            [weak self]
            (sources) in
            DispatchQueue.main.async {
                [weak self] in
            if !sources.isEmpty {
                self?.presenter?.presentData(with: sources)
            }
            }
        })
    }
    
    public func saveSources() {
        storageManager?.saveSources(completionHandler: {})
    }
}
