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
    
    @IBOutlet weak var mysticButton: UIButton!
    @IBOutlet weak var valorButton: UIButton!
    @IBOutlet weak var instinctButton: UIButton!
    
    var instinctShadow = false
    var mysticShadow = false
    var valorShadow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instinctButton.layer.shadowColor = nil
        instinctButton.layer.shadowRadius = 5
        instinctButton.layer.shadowOpacity = 1.0
        instinctButton.layer.borderColor = UIColor.clearColor().CGColor
        instinctButton.layer.borderWidth = 2
        instinctButton.layer.cornerRadius = 5
        
        mysticButton.layer.shadowColor = nil
        mysticButton.layer.shadowRadius = 5
        mysticButton.layer.shadowOpacity = 1.0
        mysticButton.layer.borderColor = UIColor.clearColor().CGColor
        mysticButton.layer.borderWidth = 2
        mysticButton.layer.cornerRadius = 5

        
        valorButton.layer.shadowColor = nil
        valorButton.layer.shadowRadius = 10
        valorButton.layer.shadowOpacity = 1.0
        valorButton.layer.borderColor = UIColor.clearColor().CGColor
        valorButton.layer.borderWidth = 2
        valorButton.layer.cornerRadius = 5

    }
    
    @IBAction func instinctAction(sender: AnyObject) {
        instinctButton.layer.shadowColor = UIColor.yellowColor().CGColor
        instinctButton.layer.borderColor = UIColor.yellowColor().CGColor
        valorButton.layer.shadowColor = UIColor.blackColor().CGColor
        valorButton.layer.borderColor = UIColor.clearColor().CGColor
        mysticButton.layer.shadowColor = UIColor.blackColor().CGColor
        mysticButton.layer.borderColor = UIColor.clearColor().CGColor

//            (UIControlState.Normal) == UIImage(named:"coolBlue"){
//            button.setBackgroundImage(nil, forState: UIControlState.Normal)
//        } else {
//            button.setBackgroundImage(UIImage(named: "coolBlue"), forState: UIControlState.Normal)
//        }
//        valorButton.setImage(UIImage(named: "VALOR Button"), forState: UIControlState.Normal)
//        mysticButton.setImage(UIImage(named: "MYSIC Button"), forState: UIControlState.Normal)
//        instinctButton.setImage(UIImage(named: "Instinct"), forState: UIControlState.Normal)
    }
   
    @IBAction func valorAction(sender: AnyObject) {
        valorButton.layer.shadowColor = UIColor.redColor().CGColor
        valorButton.layer.borderColor = UIColor.redColor().CGColor
        instinctButton.layer.shadowColor = UIColor.blackColor().CGColor
        instinctButton.layer.borderColor = UIColor.clearColor().CGColor
        mysticButton.layer.shadowColor = UIColor.blackColor().CGColor
        mysticButton.layer.borderColor = UIColor.clearColor().CGColor
        
    }
   
    @IBAction func mysticAction(sender: AnyObject) {
        mysticButton.layer.shadowColor = UIColor.blueColor().CGColor
        mysticButton.layer.borderColor = UIColor.blueColor().CGColor
        valorButton.layer.shadowColor = UIColor.blackColor().CGColor
        valorButton.layer.borderColor = UIColor.clearColor().CGColor
        instinctButton.layer.shadowColor = UIColor.blackColor().CGColor
        instinctButton.layer.borderColor = UIColor.clearColor().CGColor
    }
    @IBAction func registerAction(sender: AnyObject) {
        print("hello")
    }
}