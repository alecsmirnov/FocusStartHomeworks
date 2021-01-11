//
//  ThreadSafeArray.swift
//  homework-2
//
//  Created by Admin on 22.10.2020.
//

import Dispatch

public final class ThreadSafeArray<T> {
    public typealias ThreadSafeArrayType = [T]
    
    public typealias Element = ThreadSafeArrayType.Element
    public typealias Index = ThreadSafeArrayType.Index
    public typealias Iterator = ThreadSafeArrayType.Iterator
    
    private var data = ThreadSafeArrayType()
    
    private let queue = DispatchQueue(label: "ThreadSafeArrayQueue", attributes: .concurrent)
    
    public init() {}
}

extension ThreadSafeArray where Element: Equatable {
    public func contains(_ element: Element) -> Bool {
        return queue.sync { data.contains(element) }
    }
}

// MARK: - Collection

extension ThreadSafeArray: Collection {
    public var isEmpty: Bool {
        return queue.sync { data.isEmpty }
    }

    public var count: Int {
        return queue.sync { data.count }
    }

    public var startIndex: Index {
        return queue.sync { data.startIndex }
    }

    public var endIndex: Index {
        return queue.sync { data.endIndex }
    }

    public func index(after i: Index) -> Index {
        return queue.sync {
            guard data.indices.contains(i) else {
                fatalError("index is out of range")
            }
            
            return data.index(after: i)
        }
    }

    public subscript(index: Index) -> Element {
        get {
            return queue.sync {
                guard data.indices.contains(index) else {
                    fatalError("index is out of range")
                }
                
                return data[index]
            }
        }
        set {
            queue.async(flags: .barrier) { [self] in
                guard data.indices.contains(index) else {
                    fatalError("index is out of range")
                }
                
                data[index] = newValue
            }
        }
    }
}

// MARK: - RangeReplaceableCollection

extension ThreadSafeArray: RangeReplaceableCollection {
    public func append(_ element: Element) {
        queue.async(flags: .barrier) { [self] in
            data.append(element)
        }
    }
        
    public func remove(at index: Index) -> Element {
        return queue.sync(flags: .barrier) {
            guard data.indices.contains(index) else {
                fatalError("index is out of range")
            }
            
            return data.remove(at: index)
        }
    }
}

// MARK: - ExpressibleByArrayLiteral

extension ThreadSafeArray: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: Element...) {
        self.init()
        
        for element in elements {
            append(element)
        }
    }
}

// MARK: - Sequence

extension ThreadSafeArray: Sequence {
    public func makeIterator() -> Iterator {
        return data.makeIterator()
    }
}
