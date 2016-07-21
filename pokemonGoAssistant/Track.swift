//
//  Track.swift
//  pokemonGoAssistant
//
//  Created by Anthony Kim on 7/16/16.
//  Copyright (c) 2016 anthonykim. All rights reserved.
//

import UIKit

class Track: UIViewController {
    @IBOutlet weak var longView: UIView!
    
    var count = 0
    var selected = false

    var nameData = ["bulbasaur", "ivysaur", "venusaur", "charmander", "charmeleon", "charizard", "squirtle", "wartortle", "blastoise", "caterpie", "metapod", "butterfree", "weedle", "kakuna", "beedrill", "pidgey", "pidgeotto", "pidgeot", "rattata", "raticate", "spearow", "fearow", "ekans", "arbok", "pikachu", "raichu", "sandshrew", "sandslash", "nidoran-f", "nidorina", "nidoqueen", "nidoran-m", "nidorino", "nidoking", "clefairy", "clefable", "vulpix", "ninetales", "jigglypuff", "wigglytuff", "zubat", "golbat", "oddish", "gloom", "vileplume", "paras", "parasect", "venonat", "venomoth", "diglett", "dugtrio", "meowth", "persian", "psyduck", "golduck", "mankey", "primeape", "growlithe", "arcanine", "poliwag", "poliwhirl", "poliwrath", "abra", "kadabra", "alakazam", "machop", "machoke", "machamp", "bellsprout", "weepinbell", "victreebel", "tentacool", "tentacruel", "geodude", "graveler", "golem", "ponyta", "rapidash", "slowpoke", "magnemite", "magneton", "farfetchd", "doduo", "dodrio", "seel", "dewgong", "grimer", "muk", "shellder", "cloyster", "gastly", "haunter", "gengar", "onix", "drowzee", "hypno", "krabby", "kingler", "voltorb", "electrode", "exeggcute", "exeggutor", "cubone", "marowak", "hitmonlee", "hitmonchan", "lickitung", "koffing", "weezing", "rhyhorn", "rhydon", "chansey", "tangela", "kangaskhan", "horsea", "seadra", "goldeen", "seaking", "staryu", "starmie", "mr-mime", "scyther", "jynx", "electabuzz", "magmar", "pinsir", "tauros", "magikarp", "gyarados", "lapras", "ditto", "eevee", "vaporeon", "jolteon", "flareon", "porygon", "omanyte", "omastar", "kabuto", "kabutops", "aerodactyl", "snorlax", "articuno","zapdos", "moltres", "dratini", "dragonair", "dragonite", "mewtwo", "mew"]
    
    var buttons:NSMutableArray = []
    
    var x: CGFloat = 0
    var y: CGFloat = 80
    
    func trackPokemon(pokemon: UITapGestureRecognizer!) {
        let button:UIButton = pokemon.view as! UIButton
        print(button.currentTitle!, terminator: "")
        if button.backgroundImageForState(UIControlState.Normal) == UIImage(named:"pokeball"){
            button.setBackgroundImage(nil, forState: UIControlState.Normal)
        } else {
            button.setBackgroundImage(UIImage(named: "pokeball"), forState: UIControlState.Normal)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        while count < 150 {
            let tapGesture = UITapGestureRecognizer(target: self, action: Selector("trackPokemon:"))
            let pokeButton = UIButton()
            pokeButton.userInteractionEnabled = true
            pokeButton.addGestureRecognizer(tapGesture)
            pokeButton.setImage(UIImage(named: nameData[count]), forState: UIControlState.Normal)
            pokeButton.setTitle(nameData[count], forState: UIControlState.Normal)
            let multThree = count % 3
            if multThree == 0 {
                x = 20
                pokeButton.frame = CGRectMake(x, y, 80, 80)
            } else if multThree == 1 {
                x = (self.view.frame.size.width - 80)/2;
                pokeButton.frame = CGRectMake(x, y, 80, 80)
            } else {
                x = self.view.frame.size.width - 100
                pokeButton.frame = CGRectMake(x, y, 80, 80)
                y = y + 90
            }
            
            longView.addSubview(pokeButton)
            buttons.addObject(pokeButton)
            count = count + 1
        }
        
        
        
    }
    
    @IBAction func backToMap(sender: AnyObject) {
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    
    @IBAction func allSelect(sender: AnyObject) {
        if selected == false {
            for btn in buttons {
                btn.setBackgroundImage(UIImage(named: "pokeball"), forState: UIControlState.Normal)
                selected = true
            }
        } else {
            for btn in buttons {
                btn.setBackgroundImage(nil, forState: UIControlState.Normal)
            }
            selected = false
        }
        
    }



    @IBAction func save(sender: AnyObject) {
        print("hello")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



