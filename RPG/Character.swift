//
//  Character.swift
//  RPG
//
//  Created by Jonathon Day on 1/3/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation
import UIKit

class Character {
    //MARK: Stored Properties
    let name: String
    var experience: Int
    var characterClass: CharacterClass
    var healthModifier: Int
    var manaModifier: Int
    var mana: Int {
        didSet {
            if mana > maxMana {
                health = maxMana
            }
            if mana < 0 {
                mana = 0
            }
        }
    }
    
    var health: Int {
        didSet {
            if health > maxHealth {
                health = maxHealth
            }
            if health < 0 {
                health = 0
            }
        }
    }

    let image: UIImage
    
    //MARK: Computed Properties
    var jsonRepresentation: Data {
        let jsonFoundationObject: [String: Any] = [
            "name": name,
            "experience": experience,
            "characterClass": characterClass.description,
            "healthModifier": healthModifier,
            "manaModifier": manaModifier,
            "health": health,
            "mana": mana
        ]
        return try! JSONSerialization.data(withJSONObject: jsonFoundationObject, options: [])
    }

    var strength: Int {
        if characterClass == .knight {
            return 5 + level
        } else {
            return 5
        }
    }
    
    var intelligence: Int {
        if characterClass == CharacterClass.mage {
            return 5 + level
        } else {
            return 5
        }
        
    }
    
    var faith: Int {
        if characterClass == CharacterClass.cleric {
            return 5 + level
        } else {
            return 5
        }
        
    }
    
    var isDead: Bool {
        return health == 0
    }

    
    var maxHealth: Int {
        return (10 + healthModifier) * level
    }
    
    var maxMana: Int {
        return (10 + healthModifier) * level
    }
    
    var level: Int {
        return experience / 50
    }
    
    //MARK: Methods
    func heal(_ hitpoints: Int) {
        health += hitpoints
        experience += hitpoints
    }
    
    func damage(_ hitpoints: Int) {
        health -= hitpoints
        experience += hitpoints
    }
    
    static func ==(lhs: Character, rhs: Character) -> Bool {
        return lhs.name == rhs.name &&
        lhs.experience == rhs.experience &&
        lhs.characterClass == rhs.characterClass &&
        lhs.healthModifier == rhs.healthModifier &&
        lhs.manaModifier == rhs.manaModifier &&
        lhs.health == rhs.health &&
        lhs.mana == rhs.mana
    }

    //MARK: Initializer
    init(name: String, characterClass: CharacterClass) {
        self.name = name
        self.characterClass = characterClass
        
        switch characterClass {
        case .cleric:
            healthModifier = 2
            manaModifier = 2
            image = #imageLiteral(resourceName: "cleric")
        case .mage:
            healthModifier = 1
            manaModifier = 3
            image = #imageLiteral(resourceName: "mage")
        case .knight:
            healthModifier = 3
            manaModifier = 1
            image = #imageLiteral(resourceName: "knight")
        }
        
        health = 10 + healthModifier
        mana = 10 + manaModifier
        experience = 100
    }
    
    init(jsonData: Data) {
        let jsonFoundataionObject = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
        name = jsonFoundataionObject["name"] as! String
        let classAsString = jsonFoundataionObject["characterClass"] as! String
        characterClass = CharacterClass(rawValue: classAsString)!
        health = jsonFoundataionObject["health"] as! Int
        healthModifier = jsonFoundataionObject["healthModifier"] as! Int
        mana = jsonFoundataionObject["mana"] as! Int
        manaModifier = jsonFoundataionObject["manaModifier"] as! Int
        experience = jsonFoundataionObject["experience"] as! Int
        
        switch characterClass {
        case .cleric:
            healthModifier = 2
            manaModifier = 2
            image = #imageLiteral(resourceName: "cleric")
        case .mage:
            healthModifier = 1
            manaModifier = 3
            image = #imageLiteral(resourceName: "mage")
        case .knight:
            healthModifier = 3
            manaModifier = 1
            image = #imageLiteral(resourceName: "knight")
        }
    }
}
