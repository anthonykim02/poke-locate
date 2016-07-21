//
//  StartScreen.swift
//  pokemonGoAssistant
//
//  Created by Anthony Kim on 7/16/16.
//  Copyright (c) 2016 anthonykim. All rights reserved.
//
import UIKit

class StartScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func openLogin(sender: AnyObject) {
        let loginScreen : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
        self.showViewController(loginScreen as! UIViewController, sender: loginScreen)
        
       
    }
    @IBAction func openRegister(sender: AnyObject) {
        let registerScreen : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Register")
        self.showViewController(registerScreen as! UIViewController, sender: registerScreen)
    }
}

