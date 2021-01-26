//
//  DetailsBuilder.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import UIKit

public class DetailsBuilder {
    public func build() {
        let detailsViewController = ListViewController()
        
        let networkManager = NetworkManager()
        let storageManager = SourceStorageManager()
        
        let presenter = ListPresenter(viewController: detailsViewController)
        let interactor = ListInteractor(presenter: presenter, storageManager: storageManager)
        let router = ListRouter(viewController: detailsViewController)
        
        detailsViewController.presenter = presenter
        detailsViewController.interactor = interactor
        detailsViewController.router = router
        
    }
}
