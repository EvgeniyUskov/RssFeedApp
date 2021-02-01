//
//  DetailsBuilder.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import UIKit

public class DetailsBuilder {
    public func build(with newsViewModel: NewsViewModel) -> DetailsViewController{
        let detailsViewModel = DetailsViewModel(newsViewModel: newsViewModel)
        let detailsViewController = DetailsViewController(detailsViewModel: detailsViewModel)
        
        let storageManager = (UIApplication.shared.delegate as! AppDelegate).storageManager
        
        let presenter = DetailsPresenter(viewController: detailsViewController)
        let interactor = DetailsInteractor(presenter: presenter, storageManager: storageManager)
        let router = DetailsRouter(viewController: detailsViewController)
        
        detailsViewController.presenter = presenter
        detailsViewController.interactor = interactor
        detailsViewController.router = router
        return detailsViewController
    }
}
