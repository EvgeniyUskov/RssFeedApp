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
    case containsSpecificText
}

//MARK: Protocols
public protocol SourceStorageProtocol {
    func saveSources(completionHandler: @escaping () -> () )
    func loadSources(sources mode: LoadMode, searchTerm: String?, completionHandler: @escaping (([RssSource]) -> ()))
    func loadSources(with searchTerm: String, completionHandler: @escaping (([RssSource]) -> ()))
    func createSource() -> RssSource
    func addSource(with source: RssSource, completionHandler: @escaping () -> () )
    func deleteSource(source: RssSource, completionHandler: @escaping () -> () )
}

//MARK: CoreDataManager
public class SourceStorageManager{
    
    //MARK: Properties
//    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    private lazy var privateContext = container.newBackgroundContext()
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
        
    public func deleteSource(source: RssSource, completionHandler: @escaping () -> () ) {
        privateContext.delete(source)
//        sources.remove(at: indexPath.row)
        saveSources(completionHandler: {
                        completionHandler()
        })
    }
    
    public func saveSources(completionHandler: @escaping () -> () ) {
        do {
//            let privateContext = container.newBackgroundContext()
            try privateContext.save()
            completionHandler()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    public func loadSources(with searchTerm: String, completionHandler: @escaping (([RssSource]) -> ())) {
        if !searchTerm.isEmpty {
            loadSources(sources: .containsSpecificText, searchTerm: searchTerm, completionHandler: {
                sources in
                completionHandler(sources)
            })
        } else {
            loadSources(sources: .allSources, completionHandler: {
                sources in
                completionHandler(sources)
            })
        }
    }
    
    public func loadSources(sources mode: LoadMode, searchTerm: String? = nil, completionHandler: @escaping (([RssSource]) -> ())) {
        DispatchQueue.global(qos: .utility).async {
            [weak self] in
            do {
//                let privateContext = self?.container.newBackgroundContext()
                var sources: [RssSource]?
                
                switch mode {
                case .containsSpecificText:
                    if let searchTerm = searchTerm {
                        let request : NSFetchRequest<RssSource> = RssSource.fetchRequest()
                        let textContainsPredicate = NSPredicate(format: "title CONTAINS %@ OR url CONTAINS %@", searchTerm, searchTerm)
                        request.predicate = textContainsPredicate
                        if let loadedSources = try self?.privateContext.fetch(request) {
                            sources = loadedSources
                        }
                    }
                case .activeSources:
                    let request : NSFetchRequest<RssSource> = RssSource.fetchRequest()
                    let checkedPredicate = NSPredicate(format: "checked = %d", true)
                    request.predicate = checkedPredicate
                    if let loadedSources = try self?.privateContext.fetch(request) {
                        sources = loadedSources
                    }
                
                case .allSources:
                    sources = try self?.privateContext.fetch(RssSource.fetchRequest())
                }
                if let sourcesArray = sources {
                    completionHandler(sourcesArray)
                }
            } catch {
                print("Error fetching data from context \(error)")
            }
        }
    }

}