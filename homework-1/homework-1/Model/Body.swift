//
//  Body.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

enum Body: Int {
    case sedan
    case coupe
    case cabriolet
    case pickup
}

extension Body {
    var description: String {
        switch self {
        case .sedan: return "Sedan"
        case .coupe: return "Coupe"
        case .cabriolet: return "Cabriolet"
        case .pickup: return "Pick-up"
        }
    }
}

extension Body: CaseIterable {}
