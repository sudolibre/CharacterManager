//
//  CharacterClass.swift
//  RPG
//
//  Created by Jonathon Day on 1/3/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation

enum CharacterClass: String, CustomStringConvertible {
    case knight = "Knight", mage = "Mage", cleric = "Cleric"
    
    var description: String {
        switch self {
        case .knight:
            return "Knight"
        case .mage:
            return "Mage"
        case .cleric:
            return "Cleric"
        }
    }
}
