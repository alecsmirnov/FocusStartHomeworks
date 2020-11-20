//
//  main.swift
//  homework-2
//
//  Created by Admin on 22.10.2020.
//

import Foundation

let threadSafeArray = ThreadSafeArray<Int>()

let queue = DispatchQueue(label: "ThreadSafeArrayTestQueue", qos: .background, attributes: .concurrent)
let group = DispatchGroup()

let dispatchWorkItem = DispatchWorkItem {
    for i in 0...1000 {
        threadSafeArray.append(i)
    }
    
    group.leave()
}

group.enter()
queue.async(execute: dispatchWorkItem)

group.enter()
queue.async(execute: dispatchWorkItem)

group.wait()

print("Elements count: \(threadSafeArray.count)")
