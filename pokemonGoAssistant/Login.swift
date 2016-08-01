//
//  Login.swift
//  pokemonGoAssistant
//
//  Created by Anthony Kim on 7/16/16.
//  Copyright (c) 2016 anthonykim. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

class Login: UIViewController, UITextFieldDelegate {
//    @IBOutlet weak var usernameField: UITextField!
//    @IBOutlet weak var passwordField: UITextField!
//    @IBOutlet weak var loginButton: UIButton!
//    @IBOutlet weak var errorMessage: UILabel!
    
    let loginTitle = UILabel()
    let charizard = UIImageView()
    let userField = UITextField()
    let passField = UITextField()
    let userLine = UIImageView()
    let passLine = UIImageView()
    let login = UIButton()
    let errorMsg = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenHeight = self.view.frame.height
        let screenWidth = self.view.frame.width
   
//        usernameField.delegate = self
//        passwordField.delegate = self
        
        userField.delegate = self
        passField.delegate = self
        
        let labelColor = UIColor().HexToColor("#f8f3eb", alpha: 1.0)
        let fieldSize = CGSize(width: screenWidth * 0.75, height: screenHeight / 15)
        
        loginTitle.text = "LOG IN"
        loginTitle.font = UIFont(name: "Aleo-Regular", size: screenHeight / 12)
        loginTitle.frame = CGRect(x: (screenWidth / 2) - (fieldSize.width / 2), y: screenHeight / 20, width: fieldSize.width, height: screenHeight / 10)
        loginTitle.textColor = labelColor
        loginTitle.textAlignment = NSTextAlignment.Center
        
        let imageSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)
        charizard.image = UIImage(named: "charizardCool")
         charizard.frame = CGRect(x: (screenWidth / 2) - (imageSize.width / 2), y: (screenHeight / 4) - (imageSize.height / 3), width: imageSize.width, height: imageSize.height)
        
        userField.borderStyle = UITextBorderStyle.None
        passField.borderStyle = UITextBorderStyle.None
        
        userField.attributedPlaceholder = NSAttributedString(string:"USERNAME",
                                                               attributes:[NSForegroundColorAttributeName: labelColor])
        userField.font = UIFont(name: "Aleo-Regular", size: screenHeight / 25)
        userField.textColor = labelColor
        passField.attributedPlaceholder = NSAttributedString(string:"PASSWORD",
                                                              attributes:[NSForegroundColorAttributeName: labelColor])
        passField.font = UIFont(name: "Aleo-Regular", size: screenHeight / 25)
        passField.textColor = labelColor
        
        let lineSize = CGSize(width: screenWidth * 0.75, height: screenHeight / 300)
        userLine.image = UIImage(named: "Line")
        passLine.image = UIImage(named: "Line")
        
        userLine.frame = CGRect(x: (screenWidth / 2) - (lineSize.width / 2), y: (screenHeight / 2) - lineSize.height, width: lineSize.width, height: screenHeight / 300)
        passLine.frame = CGRect(x: (screenWidth / 2) - (lineSize.width / 2), y: (screenHeight / 2) + fieldSize.height, width: lineSize.width, height: screenHeight / 300)
        userField.frame = CGRect(x: (screenWidth / 2) - (fieldSize.width / 2), y: (screenHeight / 2) - (fieldSize.height + lineSize.height), width: fieldSize.width, height: fieldSize.height)
        passField.frame = CGRect(x: (screenWidth / 2) - (fieldSize.width / 2), y: screenHeight / 2, width: fieldSize.width, height: fieldSize.height)
        
        let buttonSize = CGSize(width: screenWidth * 0.75, height: screenHeight / 10)
        login.setImage(UIImage(named: "Login Button rounded"), forState: UIControlState.Normal)
        login.frame = CGRect(x: (screenWidth / 2) - (buttonSize.width / 2), y: screenHeight - (screenHeight / 15 + buttonSize.height), width: buttonSize.width, height: buttonSize.height)
        login.addTarget(self, action: Selector("loginButton:"),forControlEvents: .TouchUpInside)
        
        errorMsg.textColor = UIColor.redColor()
        errorMsg.text = "error message"
        errorMsg.font = UIFont(name: "Aleo-Regular", size: screenHeight / 40)
        errorMsg.frame = CGRect(x: (screenWidth / 2) - (fieldSize.width / 2), y: (login.frame.minY + passLine.frame.maxY) / 2.5, width: fieldSize.width, height: fieldSize.height * 2)
        errorMsg.numberOfLines = 2
        errorMsg.textAlignment = NSTextAlignment.Center
        errorMsg.hidden = true
        
        self.view.addSubview(loginTitle)
        self.view.addSubview(charizard)
        self.view.addSubview(userField)
        self.view.addSubview(userLine)
        self.view.addSubview(passField)
        self.view.addSubview(passLine)
        self.view.addSubview(errorMsg)
        self.view.addSubview(login)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
//    
//    @IBAction func loginAction(sender: AnyObject) {
//        Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/users/authenticate", parameters: ["username": usernameField.text!, "password" : passwordField.text!]).validate()
//            .responseJSON { (_, _, response) in
//                if let json = response.value {
//                    var json = JSON(response.value!)
//                    var success = json["success"].stringValue
//                    if success == "0" {
//                        let defaults = NSUserDefaults()
//                        defaults.setObject(json["user"]["id"].stringValue, forKey: "user_id")
//                        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController")
//                        let settings = UIUserNotificationSettings(forTypes: .Alert, categories: nil)
//                        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
//                        UIApplication.sharedApplication().registerForRemoteNotifications()
//                        self.showViewController(vc as! UIViewController, sender: vc)
//                    } else {
//                        self.errorMessage.text = "The username or password is incorrect."
//                        self.errorMessage.hidden = false
//                    }
//                } else {
//                    self.errorMessage.text = "Connection Error: Server not found"
//                    self.errorMessage.hidden = false
//                }
//                
//        }
//    }
    
    func loginButton(sender: UIButton!) {
        Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/users/authenticate", parameters: ["username": userField.text!, "password" : passField.text!]).validate()
            .responseJSON { (_, _, response) in
                if let json = response.value {
                    var json = JSON(response.value!)
                    var success = json["success"].stringValue
                    if success == "0" {
                        let defaults = NSUserDefaults()
                        defaults.setObject(json["user"]["id"].stringValue, forKey: "user_id")
                        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController")
                        let settings = UIUserNotificationSettings(forTypes: .Alert, categories: nil)
                        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
                        UIApplication.sharedApplication().registerForRemoteNotifications()
                        self.showViewController(vc as! UIViewController, sender: vc)
                    } else {
                        self.errorMsg.text = "The username or password is incorrect."
                        self.errorMsg.hidden = false
                    }
                } else {
                    self.errorMsg.text = "Connection Error: Server not found"
                    self.errorMsg.hidden = false
                }
                
        }
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Home")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    
    func goBack(sender: UIButton!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Home")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

