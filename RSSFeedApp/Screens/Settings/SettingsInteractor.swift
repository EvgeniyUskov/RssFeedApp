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
    public func loadSources() {
        storageManager?.loadSources(sources: .allSources, completionHandler: { (sources) in
            self.presenter?.presentData(with: sources)
        })
    }
    
    public func saveSources() {
        storageManager?.saveSources(completionHandler: {})
    }
}
