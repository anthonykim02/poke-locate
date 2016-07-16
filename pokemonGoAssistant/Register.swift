//
//  Register.swift
//  pokemonGoAssistant
//
//  Created by Anthony Kim on 7/16/16.
//  Copyright (c) 2016 anthonykim. All rights reserved.
//

import UIKit

class Register: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var teamButton: UISegmentedControl!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func registerAction(sender: AnyObject) {
        print("hello")
    }
}