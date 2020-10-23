//
//  ThreadSafeArray.swift
//  homework-2
//
//  Created by Admin on 22.10.2020.
//

import Foundation

final class ThreadSafeArray<T> {
    typealias ThreadSafeArrayType = [T]
    
    typealias Element = ThreadSafeArrayType.Element
    typealias Index = ThreadSafeArrayType.Index
    typealias Iterator = ThreadSafeArrayType.Iterator
    
    private var data = ThreadSafeArrayType()
    private let queue = DispatchQueue(label: "ThreadSafeArrayQueue", attributes: .concurrent)
}

extension ThreadSafeArray where Element: Equatable {
    func contains(_ element: Element) -> Bool {
        var contains = false

        queue.sync {
            contains = data.contains(element)
        }

        return contains
    }
}

// MARK: - Collection

extension ThreadSafeArray: Collection {
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

    var startIndex: Index {
        queue.sync {
            return data.startIndex
        }
    }

    var endIndex: Index {
        queue.sync {
            data.endIndex
        }
    }

    func index(after i: Index) -> Index {
        queue.sync {
            return data.index(after: i)
        }
    }

    subscript(index: Index) -> Element {
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

extension ThreadSafeArray: RangeReplaceableCollection {
    func append(_ element: Element) {
        queue.async(flags: .barrier) {
            self.data.append(element)
        }
    }
        
    func remove(at index: Index) -> Element {
        var element: Element!
        
        queue.sync {
            element = data.remove(at: index)
        }
        
        return element
    }
}

// MARK: - ExpressibleByArrayLiteral

extension ThreadSafeArray: ExpressibleByArrayLiteral {
    convenience init(arrayLiteral elements: Element...) {
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
    func makeIterator() -> Iterator {
        return data.makeIterator()
    }
}
