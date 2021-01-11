//
//  Date+random.swift
//  homework-4
//
//  Created by Admin on 04.11.2020.
//

import Foundation

extension Date {
    static func random() -> Date {
        let randomTime = TimeInterval(arc4random())
        
        return Date(timeIntervalSince1970: randomTime)
    }
}
