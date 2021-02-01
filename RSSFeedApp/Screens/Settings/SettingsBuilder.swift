//
//  SettingsBuilder.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import UIKit

public class SettingsBuilder {
    public func build() -> SettingsViewController {
        
        let settingsViewController = SettingsViewController()
        
        let storageManager = (UIApplication.shared.delegate as! AppDelegate).storageManager
        
        let presenter = SettingsPresenter(viewController: settingsViewController)
        let interactor = SettingsInteractor(presenter: presenter, storageManager: storageManager)
        let router = SettingsRouter(viewController: settingsViewController)
        
        presenter.interactor = interactor
        
        settingsViewController.presenter = presenter
        settingsViewController.interactor = interactor
        settingsViewController.router = router
        
        return settingsViewController
    }
}
