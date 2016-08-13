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

class Register: UIViewController, UITextFieldDelegate {
    
//    @IBOutlet weak var nameField: UITextField!
//    @IBOutlet weak var numberField: UITextField!
//    @IBOutlet weak var usernameField: UITextField!
//    @IBOutlet weak var passwordField: UITextField!
//    @IBOutlet weak var registerButton: UIButton!
//    
//    @IBOutlet weak var mysticButton: UIButton!
//    @IBOutlet weak var valorButton: UIButton!
//    @IBOutlet weak var instinctButton: UIButton!
//    @IBOutlet weak var errorMessage: UILabel!
//    
//    var instinctShadow = false
//    var mysticShadow = false
//    var valorShadow = false
    
    
    let name = UITextField()
    let nameLine = UIImageView()
    let phone = UITextField()
    let phoneLine = UIImageView()
    let username = UITextField()
    let userLine = UIImageView()
    let password = UITextField()
    let passLine = UIImageView()
    let team = UILabel()
    let registerTitle = UILabel()
    let mystic = UIButton()
    let valor = UIButton()
    let instinct = UIButton()
    let regButton = UIButton()
    let errorMsg = UILabel()
    let moltres = UIImageView()
    let zapdos = UIImageView()
    let articuno = UIImageView()
    
    // instruction popups
    let shadow = UIView()
    
    let clickAnnotation = UIView()
    let ratePosts = UIView()
    let reportPokemon = UIView()
    
    let mapImage1 = UIImageView()
    let mapImage2 = UIImageView()
    let reportImage = UIImageView()
    
    let annotationText = UILabel()
    let rateText = UILabel()
    let reportText = UILabel()
    
    let annotationTitle = UILabel()
    let rateTitle = UILabel()
    let reportTitle = UILabel()
    
    let annotationNext = UIButton()
    let rateNext = UIButton()
    let reportNext = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        nameField.delegate = self
//        numberField.delegate = self
//        usernameField.delegate = self
//        passwordField.delegate = self
//        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
//
//        instinctButton.layer.shadowColor = nil
//        instinctButton.layer.shadowRadius = 5
//        instinctButton.layer.shadowOpacity = 1.0
//        instinctButton.layer.borderColor = UIColor.clearColor().CGColor
//        instinctButton.layer.borderWidth = 2
//        instinctButton.layer.cornerRadius = 5
//        
//        mysticButton.layer.shadowColor = nil
//        mysticButton.layer.shadowRadius = 5
//        mysticButton.layer.shadowOpacity = 1.0
//        mysticButton.layer.borderColor = UIColor.clearColor().CGColor
//        mysticButton.layer.borderWidth = 2
//        mysticButton.layer.cornerRadius = 5
//
//        
//        valorButton.layer.shadowColor = nil
//        valorButton.layer.shadowRadius = 10
//        valorButton.layer.shadowOpacity = 1.0
//        valorButton.layer.borderColor = UIColor.clearColor().CGColor
//        valorButton.layer.borderWidth = 2
//        valorButton.layer.cornerRadius = 5

        // ========================== ui programmatically ==================
        
        name.delegate = self
        phone.delegate = self
        username.delegate = self
        password.delegate = self
        
        let screenHeight = self.view.frame.size.height
        let screenWidth = self.view.frame.size.width
        
        let labelColor = UIColor().HexToColor("#f8f3eb", alpha: 1.0)
        let fieldSize = CGSize(width: screenWidth * 0.75, height: screenHeight / 15)
        let lineSize = CGSize(width: screenWidth * 0.75, height: screenHeight / 300)
        
        registerTitle.text = "REGISTER"
        registerTitle.font = UIFont(name: "Aleo-Regular", size: screenHeight / 12)
        registerTitle.frame = CGRect(x: (screenWidth / 2) - (fieldSize.width / 2), y: screenHeight / 20, width: fieldSize.width, height: screenHeight / 10)
        registerTitle.textColor = labelColor
        registerTitle.textAlignment = NSTextAlignment.Center
        
        name.borderStyle = UITextBorderStyle.None
        phone.borderStyle = UITextBorderStyle.None
        username.borderStyle = UITextBorderStyle.None
        password.borderStyle = UITextBorderStyle.None
        
        name.attributedPlaceholder = NSAttributedString(string:"NAME", attributes: [NSForegroundColorAttributeName: labelColor])
        name.font = UIFont(name: "Aleo-Regular", size: screenHeight / 25)
        name.textColor = labelColor
        
        phone.attributedPlaceholder = NSAttributedString(string:"PHONE", attributes: [NSForegroundColorAttributeName: labelColor])
        phone.font = UIFont(name: "Aleo-Regular", size: screenHeight / 25)
        phone.textColor = labelColor
        
        username.attributedPlaceholder = NSAttributedString(string:"USERNAME", attributes: [NSForegroundColorAttributeName: labelColor])
        username.font = UIFont(name: "Aleo-Regular", size: screenHeight / 25)
        username.textColor = labelColor
        
        password.attributedPlaceholder = NSAttributedString(string:"PASSWORD", attributes: [NSForegroundColorAttributeName: labelColor])
        password.font = UIFont(name: "Aleo-Regular", size: screenHeight / 25)
        password.textColor = labelColor

        
        nameLine.image = UIImage(named: "Line")
        phoneLine.image = UIImage(named: "Line")
        userLine.image = UIImage(named: "Line")
        passLine.image = UIImage(named: "Line")
        
        passLine.frame = CGRect(x: (screenWidth / 2) - (lineSize.width / 2), y: screenHeight / 2, width: lineSize.width, height: lineSize.height)
        password.frame = CGRect(x: (screenWidth / 2) - (fieldSize.width / 2), y: passLine.frame.minY -  fieldSize.height, width: fieldSize.width, height: fieldSize.height)
        
        userLine.frame = CGRect(x: (screenWidth / 2) - (lineSize.width / 2), y: password.frame.minY - lineSize.height, width: lineSize.width, height: lineSize.height)
        username.frame = CGRect(x: (screenWidth / 2) - (fieldSize.width / 2), y: userLine.frame.minY - fieldSize.height, width: fieldSize.width, height: fieldSize.height)
        
        phoneLine.frame = CGRect(x: (screenWidth / 2) - (lineSize.width / 2), y: username.frame.minY - lineSize.height, width: lineSize.width, height: lineSize.height)
        phone.frame = CGRect(x: (screenWidth / 2) - (fieldSize.width / 2), y: phoneLine.frame.minY -  fieldSize.height, width: fieldSize.width, height: fieldSize.height)
        
        nameLine.frame = CGRect(x: (screenWidth / 2) - (lineSize.width / 2), y: phone.frame.minY - lineSize.height, width: lineSize.width, height: lineSize.height)
        name.frame = CGRect(x: (screenWidth / 2) - (fieldSize.width / 2), y: nameLine.frame.minY -  fieldSize.height, width: fieldSize.width, height: fieldSize.height)
        
        let labelSize = CGSize(width: screenWidth * 0.75, height: screenHeight / 25)
        team.textColor = labelColor
        team.text = "TEAM:"
        team.font = UIFont(name: "Aleo-Regular", size: screenHeight / 25)
        team.textAlignment = NSTextAlignment.Center
        team.frame = CGRect(x: (screenWidth / 2) - (labelSize.width / 2), y: passLine.frame.maxY + (labelSize.height * 2.5), width: labelSize.width, height: labelSize.height)
        
        let buttonSize = CGSize(width: screenWidth * 0.75, height: screenHeight / 10)
        regButton.setImage(UIImage(named: "Register Button rounded"), forState: UIControlState.Normal)
        regButton.frame = CGRect(x: (screenWidth / 2) - (buttonSize.width / 2), y: screenHeight - (screenHeight / 15 + buttonSize.height), width: buttonSize.width, height: buttonSize.height)
        regButton.addTarget(self, action: Selector("regAction:"),forControlEvents: .TouchUpInside)
        
        errorMsg.textColor = UIColor.redColor()
        errorMsg.text = "error message"
        errorMsg.font = UIFont(name: "Aleo-Regular", size: screenHeight / 40)
        errorMsg.frame = CGRect(x: (screenWidth / 2) - (fieldSize.width / 2), y: (team.frame.minY + passLine.frame.maxY) / 2 - fieldSize.height, width: fieldSize.width, height: fieldSize.height * 2)
        errorMsg.numberOfLines = 2
        errorMsg.textAlignment = NSTextAlignment.Center
        errorMsg.hidden = true
        
        let teamSize = CGSize(width: screenWidth * 0.28, height: screenHeight / 20)
        instinct.setImage(UIImage(named: "INSTINCT Button"), forState: UIControlState.Normal)
        valor.setImage(UIImage(named: "VALOR Button"), forState: UIControlState.Normal)
        mystic.setImage(UIImage(named: "MYSTIC Button"), forState: UIControlState.Normal)
        instinct.frame = CGRect(x: screenWidth / 30, y: (regButton.frame.minY + team.frame.maxY) / 2 - (teamSize.height), width: teamSize.width, height: teamSize.height)
        valor.frame = CGRect(x: (screenWidth / 2) - (teamSize.width / 2), y: (regButton.frame.minY + team.frame.maxY) / 2 - (teamSize.height), width: teamSize.width, height: teamSize.height)
        mystic.frame = CGRect(x: screenWidth - (screenWidth / 30) - teamSize.width, y: (regButton.frame.minY + team.frame.maxY) / 2 - (teamSize.height), width: teamSize.width, height: teamSize.height)
        
        articuno.image = UIImage(named: "articunoButton")
        zapdos.image = UIImage(named: "zapdosButton")
        moltres.image = UIImage(named: "moltresButton")
        
        let imageSize = CGSize(width: teamSize.width * 0.85, height: teamSize.height * 2.5)
        articuno.frame = CGRect(x: (mystic.frame.minX + mystic.frame.maxX) / 2 - (imageSize.width / 2), y: (mystic.frame.minY + mystic.frame.maxY) / 2 - (imageSize.height / 1.75), width: imageSize.width, height: imageSize.height)
        zapdos.frame = CGRect(x: (instinct.frame.minX + instinct.frame.maxX) / 2 - (imageSize.width / 2), y: (instinct.frame.minY + instinct.frame.maxY) / 2 - (imageSize.height / 1.75), width: imageSize.width, height: imageSize.height)
        moltres.frame = CGRect(x: (valor.frame.minX + valor.frame.maxX) / 2 - (imageSize.width / 2), y: (valor.frame.minY + valor.frame.maxY) / 2 - (imageSize.height / 1.75), width: imageSize.width, height: imageSize.height)
        
        articuno.hidden = true
        moltres.hidden = true
        zapdos.hidden = true
        
        instinct.addTarget(self, action: Selector("instinctAction:"),forControlEvents: .TouchUpInside)
        valor.addTarget(self, action: Selector("valorAction:"),forControlEvents: .TouchUpInside)
        mystic.addTarget(self, action: Selector("mysticAction:"),forControlEvents: .TouchUpInside)
        
        // instructions pages
        shadow.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        shadow.backgroundColor = UIColor.blackColor()
        shadow.alpha = 0
        
        let introSize = CGSize(width: screenWidth * 0.85, height: screenHeight * 0.75)
        
        clickAnnotation.frame = CGRect(x: screenWidth * 1.5, y: (screenHeight / 2) - (introSize.height / 2), width: introSize.width, height: introSize.height)
        clickAnnotation.backgroundColor = UIColor().HexToColor("#aaff80", alpha: 1.0)
        clickAnnotation.layer.cornerRadius = 10.0
        clickAnnotation.layer.borderColor = UIColor.grayColor().CGColor
        clickAnnotation.layer.borderWidth = 0.5
        clickAnnotation.layer.shadowColor = UIColor.blackColor().CGColor
        clickAnnotation.layer.shadowOffset = CGSize(width: 0, height: 3)
        clickAnnotation.layer.shadowOpacity = 0.4
        clickAnnotation.layer.shadowRadius = 4
        
        ratePosts.frame = CGRect(x: screenWidth * 1.5, y: (screenHeight / 2) - (introSize.height / 2), width: introSize.width, height: introSize.height)
        ratePosts.backgroundColor = UIColor().HexToColor("#ffc266", alpha: 1.0)
        ratePosts.layer.cornerRadius = 10.0
        ratePosts.layer.borderColor = UIColor.grayColor().CGColor
        ratePosts.layer.borderWidth = 0.5
        ratePosts.layer.shadowColor = UIColor.blackColor().CGColor
        ratePosts.layer.shadowOffset = CGSize(width: 0, height: 3)
        ratePosts.layer.shadowOpacity = 0.4
        ratePosts.layer.shadowRadius = 4
        
        reportPokemon.frame = CGRect(x: screenWidth * 1.5, y: (screenHeight / 2) - (introSize.height / 2), width: introSize.width, height: introSize.height)
        reportPokemon.backgroundColor = UIColor().HexToColor("#b3f0ff", alpha: 1.0)
        reportPokemon.layer.cornerRadius = 10.0
        reportPokemon.layer.borderColor = UIColor.grayColor().CGColor
        reportPokemon.layer.borderWidth = 0.5
        reportPokemon.layer.shadowColor = UIColor.blackColor().CGColor
        reportPokemon.layer.shadowOffset = CGSize(width: 0, height: 3)
        reportPokemon.layer.shadowOpacity = 0.4
        reportPokemon.layer.shadowRadius = 4
        
        
//        ratePosts.frame = CGRect(x: (screenWidth / 2) - (introSize.width / 2), y: (screenHeight / 2) - (introSize.height / 2), width: introSize.width, height: introSize.height)
//        reportPokemon.frame = CGRect(x: (screenWidth / 2) - (introSize.width / 2), y: (screenHeight / 2) - (introSize.height / 2), width: introSize.width, height: introSize.height)
        
//        let mapImage1 = UIImageView()
//        let mapImage2 = UIImageView()
//        let reportImage = UIImageView()
//        
//        let annotationText = UILabel()
//        let rateText = UILabel()
//        let reportText = UILabel()
//        
//        let annotationTitle = UILabel()
//        let rateTitle = UILabel()
//        let reportTitle = UILabel()
//        
//        let annotationNext = UIButton()
//        let rateNext = UIButton()
//        let reportNext = UIButton()
        
        let imageSize2 = CGSize(width: introSize.width * 0.6, height: introSize.height * 0.7)
        
        mapImage1.image = UIImage(named: "instruction1")
        mapImage1.frame = CGRect(x: screenWidth * 0.025, y: introSize.height * 0.15, width: imageSize2.width, height: imageSize2.height)
        mapImage1.layer.masksToBounds = true
        mapImage1.layer.cornerRadius = 5.0
        
        mapImage2.image = UIImage(named: "instruction1")
        mapImage2.frame = CGRect(x: screenWidth * 0.025, y: introSize.height * 0.15, width: imageSize2.width, height: imageSize2.height)
        mapImage2.layer.masksToBounds = true
        mapImage2.layer.cornerRadius = 5.0
        
        reportImage.image = UIImage(named: "instruction2")
        reportImage.frame = CGRect(x: screenWidth * 0.025, y: introSize.height * 0.15, width: imageSize2.width, height: imageSize2.height)
        reportImage.layer.masksToBounds = true
        reportImage.layer.cornerRadius = 5.0
        
        let labelSize2 = CGSize(width: introSize.width * 0.325, height: introSize.height * 0.7)
        
        annotationText.text = "Clicking on a Pokémon displays information such as Distance, Location, Post Rating, and User Rating."
        annotationText.numberOfLines = 15
        annotationText.font = UIFont(name: "Aleo-Regular", size: screenHeight / 40)
        annotationText.frame = CGRect(x: screenWidth * 0.05 + imageSize2.width, y: introSize.height * 0.15, width: labelSize2.width, height: labelSize2.height)
        
        rateText.text = "Upvote or Downvote the post depending on whether the Pokémon is still in the area."
        rateText.numberOfLines = 15
        rateText.font = UIFont(name: "Aleo-Regular", size: screenHeight / 40)
        rateText.frame = CGRect(x: screenWidth * 0.05 + imageSize2.width, y: introSize.height * 0.15, width: labelSize2.width, height: labelSize2.height)
        
        reportText.text = "Use the Picker to Select and Report the Pokémon you find in Pokémon Go."
        reportText.numberOfLines = 15
        reportText.font = UIFont(name: "Aleo-Regular", size: screenHeight / 40)
        reportText.frame = CGRect(x: screenWidth * 0.05 + imageSize2.width, y: introSize.height * 0.15, width: labelSize2.width, height: labelSize2.height)
        
        let titleSize = CGSize(width: introSize.width * 0.75, height: introSize.height * 0.075)
        
        annotationTitle.frame = CGRect(x: (introSize.width / 2) - (titleSize.width / 2), y: introSize.height * 0.0375, width: titleSize.width, height: titleSize.height)
        annotationTitle.text = "Identifying Pokémon"
        annotationTitle.textAlignment = NSTextAlignment.Center
        annotationTitle.font = UIFont(name: "Aleo-Regular", size: screenHeight / 30)
        
        rateTitle.frame = CGRect(x: (introSize.width / 2) - (titleSize.width / 2), y: introSize.height * 0.0375, width: titleSize.width, height: titleSize.height)
        rateTitle.text = "Rating Posts"
        rateTitle.textAlignment = NSTextAlignment.Center
        rateTitle.font = UIFont(name: "Aleo-Regular", size: screenHeight / 30)
        
        reportTitle.frame = CGRect(x: (introSize.width / 2) - (titleSize.width / 2), y: introSize.height * 0.0375, width: titleSize.width, height: titleSize.height)
        reportTitle.text = "Reporting Pokémon"
        reportTitle.textAlignment = NSTextAlignment.Center
        reportTitle.font = UIFont(name: "Aleo-Regular", size: screenHeight / 30)
        
        let buttonSize2 = CGSize(width: introSize.width * 0.33, height: introSize.height * 0.075)
        
        annotationNext.frame = CGRect(x: (introSize.width / 2) - (buttonSize2.width / 2), y: introSize.height * 0.9625 - (buttonSize2.height), width: buttonSize2.width, height: buttonSize2.height)
        annotationNext.setTitle("NEXT", forState: UIControlState.Normal)
        annotationNext.titleLabel!.font = UIFont(name:"Aleo-Regular", size: screenHeight / 30)
        annotationNext.titleLabel!.textColor = UIColor.blackColor()
        annotationNext.layer.cornerRadius = 7.0
        annotationNext.backgroundColor = UIColor().HexToColor("#33cc33", alpha: 1.0)
        annotationNext.addTarget(self, action: Selector("nextAction:"), forControlEvents: .TouchUpInside)
        
        rateNext.frame = CGRect(x: (introSize.width / 2) - (buttonSize2.width / 2), y: introSize.height * 0.9625 - (buttonSize2.height), width: buttonSize2.width, height: buttonSize2.height)
        rateNext.setTitle("NEXT", forState: UIControlState.Normal)
        rateNext.titleLabel!.font = UIFont(name:"Aleo-Regular", size: screenHeight / 30)
        rateNext.titleLabel!.textColor = UIColor.blackColor()
        rateNext.layer.cornerRadius = 7.0
        rateNext.backgroundColor = UIColor().HexToColor("#ff751a", alpha: 1.0)
        rateNext.addTarget(self, action: Selector("nextAction:"), forControlEvents: .TouchUpInside)
        
        reportNext.frame = CGRect(x: (introSize.width / 2) - (buttonSize2.width / 2), y: introSize.height * 0.9625 - (buttonSize2.height), width: buttonSize2.width, height: buttonSize2.height)
        reportNext.setTitle("DONE", forState: UIControlState.Normal)
        reportNext.titleLabel!.font = UIFont(name:"Aleo-Regular", size: screenHeight / 30)
        reportNext.titleLabel!.textColor = UIColor.blackColor()
        reportNext.layer.cornerRadius = 7.0
        reportNext.backgroundColor = UIColor().HexToColor("#1a8cff", alpha: 1.0)
        reportNext.addTarget(self, action: Selector("nextAction:"), forControlEvents: .TouchUpInside)
        
        clickAnnotation.addSubview(mapImage1)
        clickAnnotation.addSubview(annotationText)
        clickAnnotation.addSubview(annotationTitle)
        clickAnnotation.addSubview(annotationNext)
        
        ratePosts.addSubview(mapImage2)
        ratePosts.addSubview(rateText)
        ratePosts.addSubview(rateTitle)
        ratePosts.addSubview(rateNext)
        
        reportPokemon.addSubview(reportImage)
        reportPokemon.addSubview(reportText)
        reportPokemon.addSubview(reportTitle)
        reportPokemon.addSubview(reportNext)
       
        self.view.addSubview(registerTitle)
        self.view.addSubview(name)
        self.view.addSubview(nameLine)
        self.view.addSubview(phone)
        self.view.addSubview(phoneLine)
        self.view.addSubview(username)
        self.view.addSubview(userLine)
        self.view.addSubview(password)
        self.view.addSubview(passLine)
        self.view.addSubview(errorMsg)
        self.view.addSubview(team)
        self.view.addSubview(regButton)
        
        self.view.addSubview(instinct)
        self.view.addSubview(valor)
        self.view.addSubview(mystic)
        self.view.addSubview(articuno)
        self.view.addSubview(zapdos)
        self.view.addSubview(moltres)
        
        self.view.addSubview(shadow)
        self.view.addSubview(clickAnnotation)
        self.view.addSubview(ratePosts)
        self.view.addSubview(reportPokemon)
        
    }
    
    func regAction(sender: UIButton!) {
        if (username.text!.characters.count < 10 && username.text!.characters.count > 0 && password.text!.characters.count > 0) {
            Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/users/add", parameters: ["name": name.text!, "username" : username.text!, "password" : password.text!, "team" : 1, "phone" : phone.text!]).validate()
                .responseJSON { (_, _, response) in
                    if let json = response.value {
                        var json = JSON(response.value!)
                        var success = json["success"].stringValue
                        if success == "0" {
                            
                            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Home")
                            self.showViewController(vc as! UIViewController, sender: vc)
                        } else {
                            self.errorMsg.text = "Account information already exists."
                            self.errorMsg.hidden = false
                        }
                    } else {
                        self.errorMsg.text = "Connection Error: Server not found"
                        self.errorMsg.hidden = false
                    }
            }
        } else {
            var errorText = "Error"
            if (username.text!.characters.count > 10) {
                errorText = "Username must be less than 10 characters."
            } else if (username.text!.characters.count == 0) {
                errorText = "Make sure to include a username."
            } else if (password.text!.characters.count == 0) {
                errorText = "Make sure to include a password."
            }
            self.errorMsg.text = errorText
            self.errorMsg.hidden = false
        }
    }
    
    func nextAction(sender: UIButton!) {
        if sender == annotationNext {
            let aHeight = self.ratePosts.frame.size.height
            let aWidth = self.ratePosts.frame.size.width
            let xCoord = (self.view.frame.size.width / 2) - (aWidth / 2)
            let yCoord = self.ratePosts.frame.origin.y
            
            UIView.animateWithDuration(0.33, animations: {
                self.clickAnnotation.frame = CGRectMake(0 - self.view.frame.size.width, yCoord, aWidth, aHeight)
                self.ratePosts.frame = CGRectMake(xCoord, yCoord, aWidth, aHeight)
            })
        } else if sender == rateNext {
            let aHeight = self.reportPokemon.frame.size.height
            let aWidth = self.reportPokemon.frame.size.width
            let xCoord = (self.view.frame.size.width / 2) - (aWidth / 2)
            let yCoord = self.reportPokemon.frame.origin.y
            
            UIView.animateWithDuration(0.33, animations: {
                self.ratePosts.frame = CGRectMake(0 - self.view.frame.size.width, yCoord, aWidth, aHeight)
                self.reportPokemon.frame = CGRectMake(xCoord, yCoord, aWidth, aHeight)
            })
        } else {
            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController")
            self.showViewController(vc as! UIViewController, sender: vc)
        }
    }
    
    func instinctAction(sender: UIButton!) {
        zapdos.hidden = false
        articuno.hidden = true
        moltres.hidden = true
        
        instinct.setImage(UIImage(named: "INSTINCT BLURRED"), forState: UIControlState.Normal)
        valor.setImage(UIImage(named: "VALOR Button"), forState: UIControlState.Normal)
        mystic.setImage(UIImage(named: "MYSTIC Button"), forState: UIControlState.Normal)
        
    }
    
    func valorAction(sender: UIButton!) {
        zapdos.hidden = true
        articuno.hidden = true
        moltres.hidden = false
        
        instinct.setImage(UIImage(named: "INSTINCT Button"), forState: UIControlState.Normal)
        valor.setImage(UIImage(named: "VALOR BLURRED"), forState: UIControlState.Normal)
        mystic.setImage(UIImage(named: "MYSTIC Button"), forState: UIControlState.Normal)
    }
    func mysticAction(sender: UIButton!) {
        zapdos.hidden = true
        articuno.hidden = false
        moltres.hidden = true
        
        instinct.setImage(UIImage(named: "INSTINCT Button"), forState: UIControlState.Normal)
        valor.setImage(UIImage(named: "VALOR Button"), forState: UIControlState.Normal)
        mystic.setImage(UIImage(named: "MYSTIC BLURRED"), forState: UIControlState.Normal)
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