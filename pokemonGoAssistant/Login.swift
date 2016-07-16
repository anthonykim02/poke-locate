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

class Login: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/users/authenticate", parameters: ["username": usernameField.text!, "password" : passwordField.text!]).validate()
            .responseJSON { (_, _, response) in
                print(response.data)
                if let json = response.value {
                    var json = JSON(response.value!)
                    print(json)
                    var success = json["success"].stringValue
                    if success == "0" {
                        print("Success = 0")
                        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController")
                        self.showViewController(vc as! UIViewController, sender: vc)
                    } else {
                        print("ERROR")
                    }
                }
        }
    }
}