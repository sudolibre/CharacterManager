//
//  RPGTests.swift
//  RPGTests
//
//  Created by Jonathon Day on 1/3/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import XCTest
@testable import RPG

class RPGTests: XCTestCase {
    
    func testDamageHealth() {
        let character = Character(name: "Bob", characterClass: .knight)
        character.damage(2)
        XCTAssertTrue(character.health == 11)
        character.damage(15)
        XCTAssertTrue(character.health == 0)
    }
    
    func testHealHealth() {
        let character = Character(name: "Bob", characterClass: .knight)
        character.damage(4)
        character.heal(2)
        XCTAssertTrue(character.health == 11)
        character.heal(4)
        XCTAssertTrue(character.health == 13)
    }
    
    func testExperience() {
        let character = Character(name: "Bob", characterClass: .knight)
        character.damage(4)
        character.heal(2)
        XCTAssertTrue(character.experience == 6)
    }
    
    
    func testJsonRepresentations() {
        let character = Character(name: "Bob", characterClass: .knight)
        character.damage(2)
        let jsonObject = character.jsonRepresentation
        let jsonCharacter = Character(jsonData: jsonObject)
        XCTAssertTrue(character == jsonCharacter)
        
    }
    
//    func testUserNav() {
//        var characters = [Character(name: "Bob", characterClass: .knight), Character(name: "Gertrude", characterClass: .cleric), Character(name: "Cornelius", characterClass: .mage)]
//        var currentCharacter = characters[0]
//        var expected = userNav(offset: 1, currentCharacter: currentCharacter, array: characters)
//        var result = characters[1]
//        XCTAssertTrue(expected === result)
//        expected = userNav(offset: 2, currentCharacter: currentCharacter, array: characters)
//        result = characters[0]
//        XCTAssertTrue(expected === result)
//        expected = userNav(offset: -, currentCharacter: currentCharacter, array: characters)
//        result = characters[2]
//        XCTAssertTrue(expected === result)
//    }
    
}
