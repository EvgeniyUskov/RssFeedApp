//
//  ThreadsafeString.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 29.01.2021.
//

import Foundation

public class ThreadsafeArray<T> {
    private var internalArray = [T]()
    let isolationQueue = DispatchQueue(label: "com.EugeneUskov.isolationQueue", attributes: .concurrent)
    
    public init() {
        isolationQueue.async(flags: .barrier) {
            self.internalArray = [T]()
        }
    }
    
    public init(array: [T]) {
        isolationQueue.async(flags: .barrier) {
            self.internalArray = array
        }
    }

    public var array: [T] {
        var result = [T]()
        isolationQueue.sync {
            result = self.internalArray
        }
        return result
    }
    
    public var isEmpty: Bool {
        return internalArray.isEmpty
    }
    
    public func append(_ additionalValue: T) {
        isolationQueue.async (flags: .barrier) {
            self.internalArray.append(additionalValue)
        }
    }
    
    public func append(contentsOf additionalValueArray: [T]) {
        isolationQueue.async (flags: .barrier) {
            self.internalArray.append(contentsOf: additionalValueArray)
        }
    }
    
    public func setValue(_ valueArray: [T]) {
        isolationQueue.async (flags: .barrier) {
            self.internalArray = valueArray
        }
    }
}
