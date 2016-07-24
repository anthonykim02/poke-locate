//
//  VCTracking.swift
//  pokemonGoAssistant
//
//  Created by Kunal Desai on 7/23/16.
//  Copyright © 2016 anthonykim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VCTracking: UIViewController, UITableViewDataSource
, UITableViewDelegate{

    @IBOutlet var tableView: UITableView!
    let trackingCellIdentifier = "TrackingTableViewCell"
    let pokemonList = ["bulbasaur", "ivysaur", "venusaur", "charmander", "charmeleon", "charizard", "squirtle", "wartortle", "blastoise", "caterpie", "metapod", "butterfree", "weedle", "kakuna", "beedrill", "pidgey", "pidgeotto", "pidgeot", "rattata", "raticate", "spearow", "fearow", "ekans", "arbok", "pikachu", "raichu", "sandshrew", "sandslash", "nidoran-f", "nidorina", "nidoqueen", "nidoran-m", "nidorino", "nidoking", "clefairy", "clefable", "vulpix", "ninetales", "jigglypuff", "wigglytuff", "zubat", "golbat", "oddish", "gloom", "vileplume", "paras", "parasect", "venonat", "venomoth", "diglett", "dugtrio", "meowth", "persian", "psyduck", "golduck", "mankey", "primeape", "growlithe", "arcanine", "poliwag", "poliwhirl", "poliwrath", "abra", "kadabra", "alakazam", "machop", "machoke", "machamp", "bellsprout", "weepinbell", "victreebel", "tentacool", "tentacruel", "geodude", "graveler", "golem", "ponyta", "rapidash", "slowpoke", "magnemite", "magneton", "farfetchd", "doduo", "dodrio", "seel", "dewgong", "grimer", "muk", "shellder", "cloyster", "gastly", "haunter", "gengar", "onix", "drowzee", "hypno", "krabby", "kingler", "voltorb", "electrode", "exeggcute", "exeggutor", "cubone", "marowak", "hitmonlee", "hitmonchan", "lickitung", "koffing", "weezing", "rhyhorn", "rhydon", "chansey", "tangela", "kangaskhan", "horsea", "seadra", "goldeen", "seaking", "staryu", "starmie", "mr-mime", "scyther", "jynx", "electabuzz", "magmar", "pinsir", "tauros", "magikarp", "gyarados", "lapras", "ditto", "eevee", "vaporeon", "jolteon", "flareon", "porygon", "omanyte", "omastar", "kabuto", "kabutops", "aerodactyl", "snorlax", "articuno","zapdos", "moltres", "dratini", "dragonair", "dragonite", "mewtwo", "mew"]
    
    var pressed:[Int] = []
    let back = UIButton()
    let save = UIButton()
    let selectAll = UIButton()
    let deselectAll = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false;
        tableView.separatorStyle = .None
        self.tableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.setNeedsStatusBarAppearanceUpdate()
        addMenuBar()
        let defaults = NSUserDefaults()
        let pressedObj = defaults.objectForKey("pressed")
        if pressedObj != nil {
            pressed = pressedObj as! [Int]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count / 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:TrackingTableViewCell = tableView.dequeueReusableCellWithIdentifier(trackingCellIdentifier, forIndexPath: indexPath) as! TrackingTableViewCell
        cell.frame.size.width = self.tableView.frame.width
        let row = indexPath.row
        cell.button1.setTitle(String(3*row), forState: UIControlState.Normal)
        cell.button2.setTitle(String(3*row + 1), forState: UIControlState.Normal)
        cell.button3.setTitle(String(3*row + 2), forState: UIControlState.Normal)
        updateButton(cell.button1)
        updateButton(cell.button2)
        updateButton(cell.button3)
        cell.button1.addTarget(self, action: "pokemonPressed:", forControlEvents: .TouchUpInside)
        cell.button2.addTarget(self, action: "pokemonPressed:", forControlEvents: .TouchUpInside)
        cell.button3.addTarget(self, action: "pokemonPressed:", forControlEvents: .TouchUpInside)
        cell.button1.setImage(UIImage(named:pokemonList[3 * row]), forState: UIControlState.Normal)
        cell.button2.setImage(UIImage(named:pokemonList[3 * row + 1]), forState: UIControlState.Normal)
        cell.button3.setImage(UIImage(named:pokemonList[3 * row + 2]), forState: UIControlState.Normal)
        cell.adjustButtonProperties(cell.button1, button2: cell.button2, button3: cell.button3)
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func pokemonPressed(button: UIButton!) {
        if  pressed.contains(Int((button.titleLabel?.text)!)!) {
            button.setBackgroundImage(nil, forState: UIControlState.Normal)
            pressed.removeAtIndex(pressed.indexOf(Int((button.titleLabel?.text)!)!)!)
            
        } else {
            button.setBackgroundImage(UIImage(named: "pokeball"), forState: UIControlState.Normal)
            pressed.append(Int((button.titleLabel?.text!)!)!)
        }
    }
    
    func updateButton(button: UIButton!) {
        if  pressed.contains(Int((button.titleLabel?.text)!)!) {
            button.setBackgroundImage(UIImage(named: "pokeball"), forState: UIControlState.Normal)
        } else {
            button.setBackgroundImage(nil, forState: UIControlState.Normal)
        }
        button.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
    }
    
    func addMenuBar() {
        let width = self.view.frame.width
        let distanceBetweenButtons = 3 / 90 * width
        let buttonWidth = 26 / 90 * width
        back.frame = CGRect(x: distanceBetweenButtons, y: 15, width: buttonWidth, height: 40)
        save.frame = CGRect(x: width - distanceBetweenButtons - buttonWidth, y: 15, width: buttonWidth, height: 40)
        selectAll.frame = CGRect(x: distanceBetweenButtons * 2 + buttonWidth, y: 15, width: buttonWidth, height: 40)
        deselectAll.frame = CGRect(x: distanceBetweenButtons * 2 + buttonWidth, y: 15, width: buttonWidth, height: 40)
        save.setBackgroundImage(UIImage(named: "Save Button-1"), forState: UIControlState.Normal)
        back.setBackgroundImage(UIImage(named:"backbutton"), forState: UIControlState.Normal)
        selectAll.setBackgroundImage(UIImage(named:"Select All Button-1"), forState: UIControlState.Normal)
        deselectAll.setBackgroundImage(UIImage(named: "Deselect Button"), forState: UIControlState.Normal)
        deselectAll.addTarget(self, action: "deselectButtonClicked:", forControlEvents: .TouchUpInside)
        back.addTarget(self, action: "backButtonClicked:", forControlEvents: .TouchUpInside)
        selectAll.addTarget(self, action:"selectAllClicked:", forControlEvents: .TouchUpInside)
        save.addTarget(self, action:"saveClicked:", forControlEvents: .TouchUpInside)
        deselectAll.hidden = true
        self.view.addSubview(back)
        self.view.addSubview(save)
        self.view.addSubview(selectAll)
        self.view.addSubview(deselectAll)
    }
    
    func saveClicked(button: UIButton!) {
        let defaults = NSUserDefaults()
        defaults.setObject(pressed, forKey: "pressed")
        updateTrackingNotifications()
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func backButtonClicked(button: UIButton!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func selectAllClicked(button: UIButton!) {
        selectAllButtons()
        selectAll.hidden = true
        deselectAll.hidden = false
    }
    
    func deselectButtonClicked(button: UIButton!) {
        deselectAllButtons()
        deselectAll.hidden = true
        selectAll.hidden = false
    }
    
    func selectAllButtons() {
        pressed = [Int](0...151)
        selectAllButtonsInCells()
    }
    
    func deselectAllButtons() {
        pressed = [Int]()
        selectAllButtonsInCells()
    }
    
    func selectAllButtonsInCells() {
        for j in 0...tableView.numberOfRowsInSection(0)-1 {
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: j, inSection: 0)) as? TrackingTableViewCell {
                updateButton(cell.button1)
                updateButton(cell.button2)
                updateButton(cell.button3)
            }
        }
    }

    func updateTrackingNotifications() {
        for i in [Int](0...150) {
            if pressed.contains(i) {
                addNotification(i)
            } else {
                deleteNotification(i)
            }
        }
    }
    
    func addNotification(pokemon: Int) {
        let defaults = NSUserDefaults()
        Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/notifications/add", parameters: ["pokemon": pokemon, "user" : defaults.stringForKey("user_id")!]).validate().responseJSON { (_, _, response) in
            if let json = response.value {
                var data = JSON(json)
                var succesful = data["success"].stringValue
                if succesful == "1" {
                    //print error message
                } else {
                    print("add succesful")
                }
            } else {
                print("network error")
                //network error
            }
        }
 
    }
    
    func deleteNotification(pokemon: Int) {
        let defaults = NSUserDefaults()
        Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/notifications/delete", parameters: ["pokemon": pokemon, "user" : defaults.stringForKey("user_id")!]).validate().responseJSON { (_, _, response) in
            if let json = response.value {
                var data = JSON(json)
                var succesful = data["success"].stringValue
                if succesful == "1" {
                    //print error message
                } else {
                    print("delete succesful")
                }
            } else {
                print("network error")
                //network error
            }
        }
        
    }
}
