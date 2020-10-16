//
//  Body.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

import Foundation

enum Body: String {
    case sedan     = "Седан"
    case coupe     = "Купе"
    case cabriolet = "Кабриолет"
    case pickup    = "Пикап"
    
    var id: Int {
        switch self {
        case .sedan:     return 0
        case .coupe:     return 1
        case .cabriolet: return 2
        case .pickup:    return 3
        }
    }
}

extension Body: CaseIterable {}
