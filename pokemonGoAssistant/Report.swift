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

class Report: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
 
    @IBOutlet var pokemonScroll: UIPickerView!
    
    @IBOutlet var pokemonImage: UIImageView!
    var someString1 = ""
    
    var pokemon = 0
    var pokemonIndex = 0
    
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    
    let pokemonData = ["bulbasaur", "ivysaur", "venusaur", "charmander", "charmeleon", "charizard", "squirtle", "wartortle", "blastoise", "caterpie", "metapod", "butterfree", "weedle", "kakuna", "beedrill", "pidgey", "pidgeotto", "pidgeot", "rattata", "raticate", "spearow", "fearow", "ekans", "arbok", "pikachu", "raichu", "sandshrew", "sandslash", "nidoran-f", "nidorina", "nidoqueen", "nidoran-m", "nidorino", "nidoking", "clefairy", "clefable", "vulpix", "ninetales", "jigglypuff", "wigglytuff", "zubat", "golbat", "oddish", "gloom", "vileplume", "paras", "parasect", "venonat", "venomoth", "diglett", "dugtrio", "meowth", "persian", "psyduck", "golduck", "mankey", "primeape", "growlithe", "arcanine", "poliwag", "poliwhirl", "poliwrath", "abra", "kadabra", "alakazam", "machop", "machoke", "machamp", "bellsprout", "weepinbell", "victreebel", "tentacool", "tentacruel", "geodude", "graveler", "golem", "ponyta", "rapidash", "slowpoke", "slowbro", "magnemite", "magneton", "farfetchd", "doduo", "dodrio", "seel", "dewgong", "grimer", "muk", "shellder", "cloyster", "gastly", "haunter", "gengar", "onix", "drowzee", "hypno", "krabby", "kingler", "voltorb", "electrode", "exeggcute", "exeggutor", "cubone", "marowak", "hitmonlee", "hitmonchan", "lickitung", "koffing", "weezing", "rhyhorn", "rhydon", "chansey", "tangela", "kangaskhan", "horsea", "seadra", "goldeen", "seaking", "staryu", "starmie", "mr-mime", "scyther", "jynx", "electabuzz", "magmar", "pinsir", "tauros", "magikarp", "gyarados", "lapras", "ditto", "eevee", "vaporeon", "jolteon", "flareon", "porygon", "omanyte", "omastar", "kabuto", "kabutops", "aerodactyl", "snorlax", "articuno","zapdos", "moltres", "dratini", "dragonair", "dragonite", "mewtwo", "mew"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonScroll.dataSource = self
        pokemonScroll.delegate = self
        pokemonImage.image = UIImage(named: "bulbasaur")
    }
    
    @IBAction func postAction(sender: AnyObject) {
        let defaults = NSUserDefaults()
        Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/reports/add", parameters: ["pokemon": pokemonIndex, "latitude": self.latitude, "longitude" : self.longitude, "user_id" : defaults.stringForKey("user_id")!]).validate().responseJSON { (_, _, response) in
            if let json = response.value {
                var data = JSON(json)
                var succesful = data["success"].stringValue
                if succesful == "1" {
                    //print error message
                } else {

                }
            } else {
                print("There was a network error while reporting.")
                //network error
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func backAction(sender: AnyObject) {
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
        pokemonImage.image = UIImage(named: pokemonData[row])
        someString1 = pokemonData[row]
        pokemonIndex = row
    }

}
