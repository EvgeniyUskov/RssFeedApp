//
//  StorageManager.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import UIKit

//MARK: Protocols
public protocol SourceStorageProtocol {
    func saveSources()
    func loadSources(completionHandler: @escaping (([RssSource]) -> ()))
}

//MARK: CoreDataManager
public class SourceStorageManager{
    
    //MARK: Properties
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

//MARK: HistoryStorageProtocol Implementation methods
extension SourceStorageManager: SourceStorageProtocol {
   
    public func addSource(viewModel: SourceViewModel) {
        DispatchQueue.global(qos: .utility).async {
            [weak self] in
            guard let context = self?.context else {return}
            
            let newSource = RssSource(context: context)
            newSource.url = viewModel.url
            newSource.title = viewModel.title
            newSource.checked = viewModel.checked
            
            self?.saveSources()
        }
    }
        
    public func deleteSource(viewModel: SourceViewModel) {
        context.delete(viewModel.source)
//        sources.remove(at: indexPath.row)
        saveSources()
        
//        tableView.deselectRow(at: indexPath, animated: true)
    }

    public func saveSources() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    public func loadSources(completionHandler: @escaping (([RssSource]) -> ())) {
        DispatchQueue.global(qos: .utility).async {
            [weak self] in
            do {
                let sources = try self?.context.fetch(RssSource.fetchRequest()) as! [RssSource]
                completionHandler(sources)
            } catch {
                print("Error fetching data from context \(error)")
            }
        }
    }

}
