//
//  Register.swift
//  pokemonGoAssistant
//
//  Created by Anthony Kim on 7/16/16.
//  Copyright (c) 2016 anthonykim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
        
        Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/users/add", parameters: ["name": nameField.text!, "username" : usernameField.text!, "password" : passwordField.text!, "team" : 1, "phone" : numberField.text!]).validate()
            .responseJSON { (_, _, response) in
                print(response.data)
                if let json = response.value {
                    var json = JSON(response.value!)
                    var success = json["success"].stringValue
                    if success == "0" {
                        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Home")
                        self.showViewController(vc as! UIViewController, sender: vc)
                    } else {
                        print("ERROR")
                        
                    }
                }
        }
    }
}