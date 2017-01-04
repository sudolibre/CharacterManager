//
//  ViewController.swift
//  RPG
//
//  Created by Jonathon Day on 1/3/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let characters: [Character]
    var currentCharacter: Character
    
    @IBOutlet var charImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var classLabel: UILabel!
    @IBOutlet var healthLabel: UILabel!
    @IBOutlet var manaNumber: UILabel!
    @IBOutlet var levelNumber: UILabel!
    @IBOutlet var experienceNumber: UILabel!
    @IBOutlet var hitpointsLabel: UILabel!
    @IBOutlet var stepperControl: UIStepper!
    @IBOutlet var strengthLabel: UILabel!
    @IBOutlet var intLabel: UILabel!
    @IBOutlet var faithLabel: UILabel!
    @IBOutlet var unconsciousLabel: UILabel!
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        hitpointsLabel.text = String(sender.value)
    }
    
    @IBAction func userNavForward(_ sender: UIButton) {
        currentCharacter = userNav(offset: 1, currentCharacter: currentCharacter, array: characters)
        updateView()
    }
    
    @IBAction func userNavBackward() {
        currentCharacter = userNav(offset: -1, currentCharacter: currentCharacter, array: characters)
        updateView()
    }
    
    func userNav(offset: Int, currentCharacter: Character, array: [Character]) -> Character {
        let oldIndex = characters.index { $0 === currentCharacter }!

        if offset > 0 {
            if let index = characters.index(oldIndex, offsetBy: offset, limitedBy: characters.index(before: characters.endIndex)) {
                return characters[index]
                
            } else {
                return characters[characters.startIndex]
                
            }
        } else if offset < 0 {
            if let index = characters.index(oldIndex, offsetBy: offset, limitedBy: characters.startIndex) {
                return characters[index]
            } else {
                return characters[characters.index(before: characters.endIndex)]
            }

        } else {
            return currentCharacter
        }
    }

    @IBAction func userHeal(_ sender: UIButton) {
        currentCharacter.heal(Int(stepperControl.value))
        updateView()
    }
    
    @IBAction func userDamage(_ sender: UIButton) {
        currentCharacter.damage(Int(stepperControl.value))
        updateView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView() {
        charImage.image = currentCharacter.image
        nameLabel.text = currentCharacter.name
        classLabel.text = currentCharacter.characterClass.description
        healthLabel.text = "\(currentCharacter.health.description) / \(currentCharacter.maxHealth)"
        manaNumber.text = "\(currentCharacter.mana.description) / \(currentCharacter.maxMana)"
        levelNumber.text = currentCharacter.level.description
        experienceNumber.text = "\((currentCharacter.experience % 50 ).description) / 50"
        strengthLabel.text = currentCharacter.strength.description
        intLabel.text = currentCharacter.intelligence.description
        faithLabel.text = currentCharacter.faith.description
        
        if currentCharacter.health == 0 {
            unconsciousLabel.alpha = 1
            charImage.alpha = 0.35
        } else {
            unconsciousLabel.alpha = 0
            charImage.alpha = 0.65
        }
        
        switch currentCharacter.characterClass {
        case .knight:
            self.view.backgroundColor = UIColor(red: 0.96, green: 0.85, blue: 0.78, alpha: 1)
        case .mage:
            self.view.backgroundColor = UIColor(red: 0.71, green: 0.86, blue: 1, alpha: 1)
        case .cleric:
            self.view.backgroundColor = UIColor(red: 0.68, green: 0.66, blue: 0.64, alpha: 1)
        }
    }
    
    init() {
        characters = [Character(name: "Bob", characterClass: .knight), Character(name: "Gertrude", characterClass: .cleric), Character(name: "Cornelius", characterClass: .mage)]
        currentCharacter = characters[0]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        characters = [Character(name: "Bob", characterClass: .knight), Character(name: "Gertrude", characterClass: .cleric), Character(name: "Cornelius", characterClass: .mage)]
        currentCharacter = characters[0]
        super.init(coder: aDecoder)
    }
    
}
//three stats of your choice (Agility, defense, charisma, )
//status: at least two statuses (normal | incapacitated ) If a character's health reaches 0, they should be incapacitated.
//for the currently displayed character.
//
//Character's should be serializable to JSON.
//
