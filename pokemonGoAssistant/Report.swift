//
//  Report.swift
//  pokemonGoAssistant
//
//  Created by Anthony Kim on 7/15/16.
//  Copyright (c) 2016 anthonykim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Report: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UISearchBarDelegate {
 
//    @IBOutlet var pokemonScroll: UIPickerView!
//    
//    @IBOutlet var pokemonImage: UIImageView!
    var someString1 = ""
    
    var pokemon = 0
    var pokemonIndex = 0
    
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    
    let pokeScroll = UIPickerView()
    let pokeImage = UIImageView()
    let searchBar = UISearchBar()
    let reportButton = UIButton()
    var error = Error()
    
    let orderData = ["bulbasaur", "ivysaur", "venusaur", "charmander", "charmeleon", "charizard", "squirtle", "wartortle", "blastoise", "caterpie", "metapod", "butterfree", "weedle", "kakuna", "beedrill", "pidgey", "pidgeotto", "pidgeot", "rattata", "raticate", "spearow", "fearow", "ekans", "arbok", "pikachu", "raichu", "sandshrew", "sandslash", "nidoran-f", "nidorina", "nidoqueen", "nidoran-m", "nidorino", "nidoking", "clefairy", "clefable", "vulpix", "ninetales", "jigglypuff", "wigglytuff", "zubat", "golbat", "oddish", "gloom", "vileplume", "paras", "parasect", "venonat", "venomoth", "diglett", "dugtrio", "meowth", "persian", "psyduck", "golduck", "mankey", "primeape", "growlithe", "arcanine", "poliwag", "poliwhirl", "poliwrath", "abra", "kadabra", "alakazam", "machop", "machoke", "machamp", "bellsprout", "weepinbell", "victreebel", "tentacool", "tentacruel", "geodude", "graveler", "golem", "ponyta", "rapidash", "slowpoke", "slowbro", "magnemite", "magneton", "farfetchd", "doduo", "dodrio", "seel", "dewgong", "grimer", "muk", "shellder", "cloyster", "gastly", "haunter", "gengar", "onix", "drowzee", "hypno", "krabby", "kingler", "voltorb", "electrode", "exeggcute", "exeggutor", "cubone", "marowak", "hitmonlee", "hitmonchan", "lickitung", "koffing", "weezing", "rhyhorn", "rhydon", "chansey", "tangela", "kangaskhan", "horsea", "seadra", "goldeen", "seaking", "staryu", "starmie", "mr-mime", "scyther", "jynx", "electabuzz", "magmar", "pinsir", "tauros", "magikarp", "gyarados", "lapras", "ditto", "eevee", "vaporeon", "jolteon", "flareon", "porygon", "omanyte", "omastar", "kabuto", "kabutops", "aerodactyl", "snorlax", "articuno","zapdos", "moltres", "dratini", "dragonair", "dragonite", "mewtwo", "mew"]
    
    var pokemonData = [String]()
    
    var filteredPokemon = []
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let errorRect = CGRect(x: 0, y: -1 * self.view.frame.height / 10, width: self.view.frame.width, height: self.view.frame.height / 10)
        self.error = Error(frame: errorRect)
        self.error.hidden = true
        pokemonData = orderData.sort()
        var filteredPokemon = pokemonData
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        let screenHeight = self.view.frame.size.height
        let screenWidth = self.view.frame.size.width
        
        pokeScroll.dataSource = self
        pokeScroll.delegate = self
        pokeImage.image = UIImage(named: "abra")
        
        let scrollSize = CGSize(width: screenWidth * 0.57895, height: screenHeight * 0.2671)
        pokeScroll.frame = CGRect(x: screenWidth * 0.2825, y: screenHeight * 0.16471, width: scrollSize.width, height: scrollSize.height)
        searchBar.frame = CGRect(x: screenWidth * 0.2825, y: screenHeight * 0.15, width: scrollSize.width, height: scrollSize.height / 4)
        searchBar.layer.cornerRadius = 4.0
        searchBar.clipsToBounds = true
        
        let imageSize = CGSize(width: screenWidth * 0.522, height: screenHeight * 0.293)
        pokeImage.frame = CGRect(x: screenWidth * 0.28, y: screenHeight * 0.51, width: imageSize.width, height: imageSize.height)
        
        let buttonSize = CGSize(width: screenWidth * 0.75, height: screenHeight / 10)
        reportButton.setImage(UIImage(named: "Updated report button"), forState: UIControlState.Normal)
        reportButton.frame = CGRect(x: (screenWidth / 2) - (buttonSize.width / 2), y: screenHeight * 0.875, width: buttonSize.width, height: buttonSize.height)
        reportButton.addTarget(self, action: Selector("reportAction:"), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(pokeScroll)
        self.view.addSubview(pokeImage)
        self.view.addSubview(searchBar)
        self.view.addSubview(reportButton)
        self.view.addSubview(error)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func reportAction(sender: UIButton!) {
        let defaults = NSUserDefaults()
        Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/reports/add", parameters: ["pokemon": pokemonIndex, "latitude": self.latitude, "longitude" : self.longitude, "user_id" : defaults.stringForKey("user_id")!]).validate().responseJSON { (_, _, response) in
            if let json = response.value {
                var data = JSON(json)
                var succesful = data["success"].stringValue
                if succesful == "1" {
                    UIView.animateWithDuration(0.28, animations: {
                        self.error.hidden = false
                        self.error.frame = CGRectMake(0, 0, self.error.frame.width, self.error.frame.height)
                        self.error.label.text = "Failed to report Pokémon."
                        let delay = 2.0 * Double(NSEC_PER_SEC)
                        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                        dispatch_after(time, dispatch_get_main_queue()) {
                            UIView.animateWithDuration(0.28, animations: {
                                self.error.frame = CGRectMake(0, -1 * self.error.frame.height, self.error.frame.width, self.error.frame.height)
                            })
                        }
                    })
                } else {
                    self.error.hidden = true
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            } else {
                UIView.animateWithDuration(0.28, animations: {
                    self.error.hidden = false
                    self.error.frame = CGRectMake(0, 0, self.error.frame.width, self.error.frame.height)
                    self.error.label.text = "Failed to report Pokémon."
                    let delay = 2.0 * Double(NSEC_PER_SEC)
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue()) {
                        UIView.animateWithDuration(0.28, animations: {
                            self.error.frame = CGRectMake(0, -1 * self.error.frame.height, self.error.frame.width, self.error.frame.height)
                        })
                    }
                })
            }
        }
        
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.error.hidden = true
        self.dismissViewControllerAnimated(true, completion: nil)
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pokemonData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pokemonData[row].capitalizedString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pokeImage.image = UIImage(named: pokemonData[row] as! String)
        someString1 = pokemonData[row] as! String
        pokemonIndex = row
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredPokemon = pokemonData.filter({$0.hasPrefix(lower)})
            if filteredPokemon.count > 0 {
                pokemonIndex = pokemonData.indexOf(filteredPokemon[0] as! String)!
                pokeScroll.selectRow(pokemonIndex, inComponent: 0, animated: true)
                pokeImage.image = UIImage(named: pokemonData[pokemonIndex])
            }
            
        }
    }
    
//    func serverError() {
//        
//    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}
