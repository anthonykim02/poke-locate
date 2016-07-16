//
//  Login.swift
//  pokemonGoAssistant
//
//  Created by Anthony Kim on 7/16/16.
//  Copyright (c) 2016 anthonykim. All rights reserved.
//
import UIKit

class Login: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        print("hello")
    }
}