//
//  StorageManagerStub.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import Foundation
@testable import RSSFeedApp

class StorageManagerStub: SourceStorageProtocol {
    
    var sourceArray = [RssSource]()
    
    var testCoreDataStack = TestCoreDataStack()
    
    func createSource() -> RssSource {
        let item = RssSource(context: testCoreDataStack.mainContext)
        return item
    }
    
    func loadSources(sources mode: LoadMode, searchTerm: String?, completionHandler: @escaping (([RssSource]) -> ())) {
        for i in 1 ... 5 {
            let item = RssSource(context: testCoreDataStack.mainContext)
            item.title = "Foo source \(i)"
            item.url = "https://www.foobar.com/rss"
            item.checked = true
            sourceArray.append(item)
        }
        completionHandler(sourceArray)
    }
    
    func loadSources(with searchTerm: String, completionHandler: @escaping (([RssSource]) -> ())) {
        for i in 1 ... 5 {
            let item = RssSource(context: testCoreDataStack.mainContext)
            item.title = "Foo source \(i)"
            item.url = "https://www.foobar.com/rss"
            item.checked = true
            sourceArray.append(item)
        }
        completionHandler(sourceArray)
    }
    
    func saveSources(completionHandler: @escaping () -> ()) {
        do {
            try testCoreDataStack.mainContext.save()
            completionHandler()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func addSource(with source: RssSource, completionHandler: @escaping () -> ()) {
        do {
            try testCoreDataStack.mainContext.save()
            completionHandler()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func deleteSource(source: RssSource, completionHandler: @escaping () -> ()) {
        do {
            try testCoreDataStack.mainContext.save()
            completionHandler()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
        
}
