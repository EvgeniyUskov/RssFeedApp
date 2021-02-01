//
//  SourceBuilder.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 28.01.2021.
//

import Foundation
import UIKit

public class SourceBuilder {
    public func build(with viewModel: SourceViewModel?, settingsUpdateDelegate: SettingsUpdatingDelegate) -> SourceViewController {
        
        let sourceViewController = SourceViewController()
        sourceViewController.delegate = settingsUpdateDelegate
        let storageManager = (UIApplication.shared.delegate as! AppDelegate).storageManager
        
        let presenter = SourcePresenter(viewController: sourceViewController)
        let interactor = SourceInteractor(presenter: presenter, storageManager: storageManager)
        let router = SourceRouter(viewController: sourceViewController)
        
        presenter.interactor = interactor
        
        sourceViewController.presenter = presenter
        sourceViewController.interactor = interactor
        sourceViewController.router = router
        
        if let viewModel = viewModel {
            sourceViewController.viewModel = viewModel
        }
        else {
            interactor.createRssSource()
        }
        return sourceViewController
    }
}
