//
//  ThreadSafeArray.swift
//  homework-2
//
//  Created by Admin on 22.10.2020.
//

import Foundation

final class ThreadSafeArray<T: Equatable> {
    var isEmpty: Bool {
        var isEmpty = false
        
        queue.sync {
            isEmpty = data.isEmpty
        }
        
        return isEmpty
    }
    
    var count: Int {
        var count = 0
        
        queue.sync {
            count = data.count
        }
        
        return count
    }
    
    private var data = [T]()
    private let queue = DispatchQueue(label: "ThreadSafeArrayQueue", attributes: .concurrent)
    
    func append(_ item: T) {
        queue.async(flags: .barrier) {
            self.data.append(item)
        }
    }
    
    func remove(at index: Int) {
        queue.async(flags: .barrier) {
            self.data.remove(at: index)
        }
    }
    
    func contains(_ item: T) -> Bool {
        var contains = false
        
        queue.sync {
            contains = data.contains(item)
        }
        
        return contains
    }
    
    subscript(index: Int) -> T {
        get {
            var item: T!
            
            queue.sync {
                item = self.data[index]
            }
            
            return item
        }
        set {
            queue.async(flags: .barrier) {
                self.data[index] = newValue
            }
        }
    }
}
