//
//  ListViewControllerBuilder.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import UIKit

public class ListBuilder {
    public func build() -> ListViewController {
        let listViewController = ListViewController()
        
        let storageManager = SourceStorageManager()
        let networkManager = NetworkManager()
        
        let presenter = ListPresenter(viewController: listViewController)
        let interactor = ListInteractor(presenter: presenter, storageManager: storageManager, networkManager: networkManager)
        let router = ListRouter(viewController: listViewController)
        
        listViewController.presenter = presenter
        listViewController.interactor = interactor
        listViewController.router = router
        
        return listViewController
    }
}
