//
//  SettingsInteractor.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import UIKit

//MARK: Protocols
public protocol SettingsInteractorProtocol {
    
}

//MARK: SettingsInteractor
public class SettingsInteractor {
    weak var presenter: SettingsPresenterProtocol?
    var storageManager: SourceStorageProtocol?
    
    public init(presenter: SettingsPresenterProtocol, storageManager: SourceStorageProtocol) {
        self.presenter = presenter
        self.storageManager = storageManager
    }
}

//MARK: SettingsInteractorProtocol implementation
extension SettingsInteractor: SettingsInteractorProtocol {
    
}
