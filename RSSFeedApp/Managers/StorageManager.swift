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
    func createSource() -> RssSource
    
    func loadSources(sources mode: LoadMode, searchTerm: String?, completionHandler: @escaping (([RssSource]) -> ()))
    func loadSources(with searchTerm: String, completionHandler: @escaping (([RssSource]) -> ()))
    
    func saveSources(completionHandler: @escaping () -> () )
    func addSource(with source: RssSource, completionHandler: @escaping () -> () )
    
    func deleteSource(source: RssSource, completionHandler: @escaping () -> () )
}

//MARK: CoreDataManager
public class SourceStorageManager{
    
    //MARK: Properties
    private let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    private lazy var privateContext = container.newBackgroundContext()
}

//MARK: SourceStorageProtocol Implementation methods
extension SourceStorageManager: SourceStorageProtocol {
    //MARK: Create
    public func createSource() -> RssSource {
        let newSource = RssSource(context: privateContext)
        return newSource
    }
    
    //MARK: Load
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
                var sources: [RssSource]?
                
                switch mode {
                case .containsSpecificText:
                    sources = self?.loadSourcesContainText(searchTerm: searchTerm)
                case .activeSources:
                    sources = self?.loadActiveSources()
                case .allSources:
                    sources = try self?.privateContext.fetch(RssSource.fetchRequest())
                }
                if let sourcesArray = sources {
                    completionHandler(sourcesArray)
                }
                completionHandler([RssSource]())    
            } catch {
                print("Error fetching data from context \(error)")
                completionHandler([RssSource]())
            }
        }
    }
    
    private func loadSourcesContainText(searchTerm: String?) -> [RssSource]? {
        if let searchTerm = searchTerm {
            let request : NSFetchRequest<RssSource> = RssSource.fetchRequest()
            let textContainsPredicate = NSPredicate(format: "title CONTAINS %@ OR url CONTAINS %@", searchTerm, searchTerm)
            request.predicate = textContainsPredicate
            do {
                let loadedSources = try privateContext.fetch(request)
                return loadedSources
            } catch {
                return nil
            }
        }
        return nil
    }
    
    private func loadActiveSources() -> [RssSource]? {
        let request : NSFetchRequest<RssSource> = RssSource.fetchRequest()
        let checkedPredicate = NSPredicate(format: "checked = %d", true)
        request.predicate = checkedPredicate
        do {
            let loadedSources = try privateContext.fetch(request)
            return loadedSources
        } catch {
            return nil
        }
        
    }
    
    private func loadAllSources() -> [RssSource]? {
        do {
            return try privateContext.fetch(RssSource.fetchRequest())
        } catch {
            return nil
        }
    }
    
    //MARK: Save
    public func addSource( with source: RssSource, completionHandler: @escaping () -> () ) {
        DispatchQueue.global(qos: .utility).async {
            [weak self] in
            self?.saveSources(completionHandler:{
                completionHandler()
            } )
        }
    }
    
    public func saveSources(completionHandler: @escaping () -> () ) {
        do {
            try privateContext.save()
            completionHandler()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    //MARK: Delete
    public func deleteSource(source: RssSource, completionHandler: @escaping () -> () ) {
        privateContext.delete(source)
        saveSources(completionHandler: {
            completionHandler()
        })
    }
    
    
}
