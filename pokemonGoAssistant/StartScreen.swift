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
    let logoImage = UIImage(named: "Pin Icon 2")
    let logoView:UIImageView = UIImageView()
    let SCALE_FACTOR = CGFloat(0.5)
    let logoText = UILabel()
    
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
        
        logoView.image = logoImage
        logoView.frame = CGRect(x: (screenWidth / 2) - (logoImage!.size.width * SCALE_FACTOR / 2), y: screenHeight * 0.2, width: logoImage!.size.width * SCALE_FACTOR, height: logoImage!.size.height * SCALE_FACTOR)
        
        logoText.font = UIFont(name: "Aleo-Regular", size: self.view.frame.height / 18)
        logoText.text = "PokéLocate"
        logoText.textColor = UIColor().HexToColor("#f8f3eb", alpha: 1.0)
        logoText.textAlignment = NSTextAlignment.Center
        logoText.frame = CGRect(x: (screenWidth / 2) - (buttonSize.width / 2), y: screenHeight * 0.1, width: buttonSize.width, height: buttonSize.height)
        
        self.view.addSubview(logoText)
        self.view.addSubview(logoView)
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

