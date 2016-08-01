//
//  StartScreen.swift
//  pokemonGoAssistant
//
//  Created by Anthony Kim on 7/16/16.
//  Copyright (c) 2016 anthonykim. All rights reserved.
//
import UIKit

class StartScreen: UIViewController {
    
    let loginButton = UIButton()
    let registerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenHeight = self.view.frame.height
        let screenWidth = self.view.frame.width
        
        let buttonSize = CGSize(width: screenWidth * 0.75, height: screenHeight / 10)
        loginButton.frame = CGRect(x: (screenWidth / 2) - (buttonSize.width / 2), y: screenHeight * 0.65, width: buttonSize.width, height: buttonSize.height)
        registerButton.frame = CGRect(x: (screenWidth / 2) - (buttonSize.width / 2), y: loginButton.frame.maxY + screenHeight / 25, width: buttonSize.width, height: buttonSize.height)
        
        loginButton.setImage(UIImage(named: "Login Button rounded"), forState: UIControlState.Normal)
        registerButton.setImage(UIImage(named: "Register Button rounded"), forState: UIControlState.Normal)
        
        loginButton.addTarget(self, action: Selector("openLogin:"),forControlEvents: .TouchUpInside)
        registerButton.addTarget(self, action: Selector("openRegister:"),forControlEvents: .TouchUpInside)
        
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
        
    }
    
    func openLogin(sender: UIButton!) {
        let loginScreen : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
        self.showViewController(loginScreen as! UIViewController, sender: loginScreen)

    }
  
    func openRegister(sender: UIButton!) {
        let registerScreen : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Register")
        self.showViewController(registerScreen as! UIViewController, sender: registerScreen)

    }
    
}

