//
//  ThreadSafeArray.swift
//  homework-2
//
//  Created by Admin on 22.10.2020.
//

import Foundation

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
        var contains = false

        queue.sync {
            contains = data.contains(element)
        }

        return contains
    }
}

// MARK: - Collection

extension ThreadSafeArray: Collection {
    public var isEmpty: Bool {
        var isEmpty = false

        queue.sync {
            isEmpty = data.isEmpty
        }

        return isEmpty
    }

    public var count: Int {
        var count = 0

        queue.sync {
            count = data.count
        }

        return count
    }

    public var startIndex: Index {
        queue.sync {
            return data.startIndex
        }
    }

    public var endIndex: Index {
        queue.sync {
            data.endIndex
        }
    }

    public func index(after i: Index) -> Index {
        queue.sync {
            return data.index(after: i)
        }
    }

    public subscript(index: Index) -> Element {
        get {
            var element: Element!

            queue.sync {
                element = self.data[index]
            }

            return element
        }
        set {
            queue.async(flags: .barrier) {
                self.data[index] = newValue
            }
        }
    }
}

// MARK: - RangeReplaceableCollection

extension ThreadSafeArray: RangeReplaceableCollection {
    public func append(_ element: Element) {
        queue.async(flags: .barrier) {
            self.data.append(element)
        }
    }
        
    public func remove(at index: Index) -> Element {
        var element: Element!
        
        queue.sync {
            element = data.remove(at: index)
        }
        
        return element
    }
}

// MARK: - ExpressibleByArrayLiteral

extension ThreadSafeArray: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: Element...) {
        self.init()
        
        for element in elements {
            queue.async(flags: .barrier) {
                self.data.append(element)
            }
        }
    }
}

// MARK: - Sequence

extension ThreadSafeArray: Sequence {
    public func makeIterator() -> Iterator {
        return data.makeIterator()
    }
}
