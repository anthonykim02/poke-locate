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
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        passwordField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/users/authenticate", parameters: ["username": usernameField.text!, "password" : passwordField.text!]).validate()
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
                        self.errorMessage.text = "The username or password is incorrect."
                        self.errorMessage.hidden = false
                    }
                } else {
                    self.errorMessage.text = "Connection Error: Server not found"
                    self.errorMessage.hidden = false
                }
                
        }
    }
    
    @IBAction func backAction(sender: AnyObject) {
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