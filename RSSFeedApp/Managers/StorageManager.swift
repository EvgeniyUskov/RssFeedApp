//
//  StorageManager.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import UIKit
import CoreData

//MARK: enums
public enum LoadMode {
    case activeSources
    case allSources
}

//MARK: Protocols
public protocol SourceStorageProtocol {
    func saveSources(completionHandler: @escaping () -> () )
    func loadSources(sources mode: LoadMode, completionHandler: @escaping (([RssSource]) -> ()))
    func createSource() -> RssSource
    func addSource(with source: RssSource, completionHandler: @escaping () -> () )
}

//MARK: CoreDataManager
public class SourceStorageManager{
    
    //MARK: Properties
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let privateContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
}

//MARK: HistoryStorageProtocol Implementation methods
extension SourceStorageManager: SourceStorageProtocol {
    
    public func createSource() -> RssSource {
            let newSource = RssSource(context: privateContext)
            return newSource
    }
    
    public func addSource( with source: RssSource, completionHandler: @escaping () -> () ) {
        DispatchQueue.global(qos: .utility).async {
            [weak self] in
            self?.saveSources(completionHandler:{
                completionHandler()
            } )
        }
    }
        
    public func deleteSource(viewModel: SourceViewModel) {
        privateContext.delete(viewModel.source)
//        sources.remove(at: indexPath.row)
        saveSources(completionHandler: {})
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func saveSources(completionHandler: @escaping () -> () ) {
        do {
            try privateContext.save()
            completionHandler()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    public func loadSources(sources mode: LoadMode, completionHandler: @escaping (([RssSource]) -> ())) {
        DispatchQueue.global(qos: .utility).async {
            [weak self] in
            do {
                
                var sources = [RssSource]()
                switch mode {
                case .activeSources:
                    let request : NSFetchRequest<RssSource> = RssSource.fetchRequest()
                    let checkedPredicate = NSPredicate(format: "checked = %d", true)
                    request.predicate = checkedPredicate
                    if let loadedSources = try self?.privateContext.fetch(request) {
                        sources = loadedSources
                    }
                case .allSources:
                    sources = try self?.privateContext.fetch(RssSource.fetchRequest()) as! [RssSource]
                }
                completionHandler(sources)
            } catch {
                print("Error fetching data from context \(error)")
            }
        }
    }

}
