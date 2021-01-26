//
//  SettingsBuilder.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import Foundation

public class SettingsBuilder {
    public func build() -> SettingsViewController {
        
        let settingsViewController = SettingsViewController()
        
        let storageManager = SourceStorageManager()
        
        let presenter = SettingsPresenter(viewController: settingsViewController)
        let interactor = SettingsInteractor(presenter: presenter, storageManager: storageManager)
        let router = SettingsRouter(viewController: settingsViewController)
        
        settingsViewController.presenter = presenter
        settingsViewController.interactor = interactor
        settingsViewController.router = router
        
        return settingsViewController
    }
}
