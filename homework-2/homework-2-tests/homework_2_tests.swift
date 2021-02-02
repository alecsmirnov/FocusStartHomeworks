//
//  homework_2_tests.swift
//  homework-2-tests
//
//  Created by Admin on 23.10.2020.
//

import XCTest
import homework_2

private enum TestSettings {
    static let operationsCount = 1000
}

class homework_2_tests: XCTestCase {
    func testThreadSafeArray() throws {
        let threadSafeArray = ThreadSafeArray<Int>()

        let queue = DispatchQueue(label: "ThreadSafeArrayTestQueue", qos: .background, attributes: .concurrent)
        let group = DispatchGroup()

        let dispatchWorkItem = DispatchWorkItem {
            for i in 0...TestSettings.operationsCount {
                threadSafeArray.append(i)
            }
            
            group.leave()
        }
        
        group.enter()
        queue.async(execute: dispatchWorkItem)
        
        group.enter()
        queue.async(execute: dispatchWorkItem)

        group.wait()
        
        XCTAssertEqual(threadSafeArray.count, TestSettings.operationsCount * 2 + 2)
    }
    
    func testArray() throws {
        var array = [Int]()

        let queue = DispatchQueue(label: "ArrayTestQueue", qos: .background, attributes: .concurrent)
        let group = DispatchGroup()

        let dispatchWorkItem = DispatchWorkItem {
            for i in 0...TestSettings.operationsCount {
                array.append(i)
            }
            
            group.leave()
        }
        
        group.enter()
        queue.async(execute: dispatchWorkItem)
        
        group.enter()
        queue.async(execute: dispatchWorkItem)

        group.wait()
        
        XCTAssertNotEqual(array.count, TestSettings.operationsCount * 2 + 2)
    }
}
