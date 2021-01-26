//
//  NewsListViewController.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import UIKit
import FeedKit

//MARK: Protocols
public protocol ListViewControllerProtocol: AnyObject {
    
}

public protocol ListViewControllerRoutingProtocol: AnyObject {
    
}

//MARK: ListViewController
public class ListViewController: UITableViewController {
    
    //MARK: Properties
    var presenter: ListPresenter?
    var interactor: ListInteractor?
    var router: ListRouter?
    
    var viewModel = ListViewModel(news: [])
    
    let feedURL = URL(string: "http://images.apple.com/main/rss/hotnews/hotnews.rss")!
    
    lazy var parser = FeedParser(URL: feedURL)
    
    var rssFeed: RSSFeed?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Feed"
        
        parser.parseAsync { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            
            case .success(let feed):
                self.rssFeed = feed.rssFeed
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

// MARK: - Table View Data Source
extension ListViewController {
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 4
        case 1: return self.rssFeed?.items?.count ?? 0
        default: fatalError()
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reusableCell()
        
        guard let layout = TableViewLayout(indexPath: indexPath) else { fatalError() }
        switch layout {
        case .title:        cell.textLabel?.text = self.rssFeed?.title ?? "[no title]"
        case .link:         cell.textLabel?.text = self.rssFeed?.link ?? "[no link]"
        case .description:  cell.textLabel?.text = self.rssFeed?.description ?? "[no description]"
        case .date:         cell.textLabel?.text = self.rssFeed?.lastBuildDate?.description ?? "[no date]"
        case .items:        cell.textLabel?.text = self.rssFeed?.items?[indexPath.row].title ?? "[no title]"
        }
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let layout = TableViewLayout(indexPath: indexPath) else { fatalError() }
        switch layout {
        case .title:        self.showDetailViewControllerWithText(self.rssFeed?.title ?? "[no title]")
        case .link:         self.showDetailViewControllerWithText(self.rssFeed?.link ?? "[no link]")
        case .description:  self.showDetailViewControllerWithText(self.rssFeed?.description ?? "[no link]")
        case .date:         self.showDetailViewControllerWithText(self.rssFeed?.lastBuildDate?.description ?? "[no date]")
        case .items:        self.showDetailViewControllerWithText(self.rssFeed?.items?[indexPath.row].description ?? "[no description]")
        }
    }
    
}

// MARK: - Navigation
extension ListViewController {
    func showDetailViewControllerWithText(_ text: String) {
        let viewController = DetailsViewController(text: text)
        self.show(viewController, sender: self)
    }
}

extension ListViewController: ListViewControllerProtocol {
    
}

extension ListViewController: ListViewControllerRoutingProtocol {
    
}

extension ListViewController {
    func reusableCell() -> NewsCell {
        let reuseIdentifier = Constants.Ids.newsCellReuseId
        let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! NewsCell
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
