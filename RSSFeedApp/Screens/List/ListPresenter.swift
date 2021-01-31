//
//  ListViewPresenter.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import Foundation
import FeedKit

//MARK: Protocols
public protocol ListPresenterProtocol: AnyObject {
    func presentData(with feedItems: [RSSFeedItem])
    func presentAlert(alert: UIAlertController)
}

public class ListPresenter {
    //MARK: Properties
    weak var viewController: ListViewControllerProtocol?
    private var alertPresented = false
    
    //MARK: Init
    public init(viewController: ListViewControllerProtocol) {
        self.viewController = viewController
    }
}

//MARK: ListPresenterProtocol Implementation
extension ListPresenter: ListPresenterProtocol {
    
    public func presentData(with feedItems: [RSSFeedItem]) {
        var news = [NewsViewModel]()
        for item in feedItems {
            news.append(NewsViewModel(pubDate: item.pubDate, title: item.title, text: item.description))
        }
        viewController?.displayData(viewModel: ListViewModel(news: news.sorted(by: >)))
    }
    
    public func presentAlert(alert: UIAlertController) {
        if !alertPresented {
            viewController?.displayAlert(alert: alert)
            alertPresented = true
        }
    }
}
