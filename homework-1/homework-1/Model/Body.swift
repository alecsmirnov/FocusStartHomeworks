//
//  Body.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

enum Body: String {
    case sedan = "Sedan"
    case coupe = "Coupe"
    case cabriolet = "Cabriolet"
    case pickup = "Pick-up"
    
    var id: Int {
        switch self {
        case .sedan: return 0
        case .coupe: return 1
        case .cabriolet: return 2
        case .pickup: return 3
        }
    }
}

// MARK: - Static Methods

extension Body {
    static func getCase(byId value: Int) -> Body? {
        switch value {
        case 0: return sedan
        case 1: return coupe
        case 2: return cabriolet
        case 3: return pickup
        default: return nil
        }
    }
}

// MARK: - CaseIterable

extension Body: CaseIterable {}
