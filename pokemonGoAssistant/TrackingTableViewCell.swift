//
//  TrackingTableViewCell.swift
//  pokemonGoAssistant
//
//  Created by Kunal Desai on 7/23/16.
//  Copyright © 2016 anthonykim. All rights reserved.
//

import UIKit

class TrackingTableViewCell: UITableViewCell {

    let img1:UIImageView = UIImageView()
    let img2:UIImageView = UIImageView()
    let img3:UIImageView = UIImageView()
    
    let button1:UIButton = UIButton()
    let button2:UIButton = UIButton()
    let button3:UIButton = UIButton()
    
    let pokemonList = ["bulbasaur", "ivysaur", "venusaur", "charmander", "charmeleon", "charizard", "squirtle", "wartortle", "blastoise", "caterpie", "metapod", "butterfree", "weedle", "kakuna", "beedrill", "pidgey", "pidgeotto", "pidgeot", "rattata", "raticate", "spearow", "fearow", "ekans", "arbok", "pikachu", "raichu", "sandshrew", "sandslash", "nidoran-f", "nidorina", "nidoqueen", "nidoran-m", "nidorino", "nidoking", "clefairy", "clefable", "vulpix", "ninetales", "jigglypuff", "wigglytuff", "zubat", "golbat", "oddish", "gloom", "vileplume", "paras", "parasect", "venonat", "venomoth", "diglett", "dugtrio", "meowth", "persian", "psyduck", "golduck", "mankey", "primeape", "growlithe", "arcanine", "poliwag", "poliwhirl", "poliwrath", "abra", "kadabra", "alakazam", "machop", "machoke", "machamp", "bellsprout", "weepinbell", "victreebel", "tentacool", "tentacruel", "geodude", "graveler", "golem", "ponyta", "rapidash", "slowpoke", "slowbro", "magnemite", "magneton", "farfetchd", "doduo", "dodrio", "seel", "dewgong", "grimer", "muk", "shellder", "cloyster", "gastly", "haunter", "gengar", "onix", "drowzee", "hypno", "krabby", "kingler", "voltorb", "electrode", "exeggcute", "exeggutor", "cubone", "marowak", "hitmonlee", "hitmonchan", "lickitung", "koffing", "weezing", "rhyhorn", "rhydon", "chansey", "tangela", "kangaskhan", "horsea", "seadra", "goldeen", "seaking", "staryu", "starmie", "mr-mime", "scyther", "jynx", "electabuzz", "magmar", "pinsir", "tauros", "magikarp", "gyarados", "lapras", "ditto", "eevee", "vaporeon", "jolteon", "flareon", "porygon", "omanyte", "omastar", "kabuto", "kabutops", "aerodactyl", "snorlax", "articuno","zapdos", "moltres", "dratini", "dragonair", "dragonite", "mewtwo", "mew"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(button1)
        self.addSubview(button2)
        self.addSubview(button3)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func pokemonTapped(img: UIImageView) {
        let backgroundImage:UIImage = UIImage(named: "pokeball")!
        let imageSubView:UIImageView = UIImageView(image:backgroundImage)
        let x = img.frame.origin.x
        let y = img.frame.origin.y
        let width = img.frame.width
        let height = img.frame.height
        imageSubView.bounds = CGRect(x: x, y: y, width: width, height: height)
        img.addSubview(imageSubView)
    }
    
    func adjustImageProperties(img1: UIImageView, img2: UIImageView, img3: UIImageView) {
        let width = self.frame.width
        let height = self.frame.height
        let topHeight = height / 10
        let distanceBetweenImg = (width / 90) * 3
        let imageWidth = width / 90 * 26
        let imageHeight = imageWidth
        setImageDimensions(img1, width: imageWidth, height: imageHeight, x: distanceBetweenImg, y:topHeight)
        setImageDimensions(img2, width: imageWidth, height: imageHeight, x: distanceBetweenImg * 2 + imageWidth, y: topHeight)
        setImageDimensions(img3, width: imageWidth, height: imageHeight, x: distanceBetweenImg * 3 + imageWidth * 2, y: topHeight)
        
    }
    
    func adjustButtonProperties(button1: UIButton, button2: UIButton, button3: UIButton) {
        let width = self.frame.width
        let height = self.frame.height
        let topHeight = height / 10
        let distanceBetweenImg = (width / 90) * 3
        let imageWidth = width / 90 * 26
        let imageHeight = imageWidth
        setButtonDimensions(button1, width: imageWidth, height: imageHeight, x: distanceBetweenImg, y: topHeight)
        setButtonDimensions(button2, width: imageWidth, height: imageHeight, x: distanceBetweenImg * 2 + imageWidth, y: topHeight)
        setButtonDimensions(button3, width: imageWidth, height: imageHeight, x: distanceBetweenImg * 3 + imageWidth * 2, y: topHeight)
    }
    
    func setButtonDimensions(button: UIButton, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat) {
        button.frame = CGRectMake(x, y, width, height)
    }
    
    func setImageDimensions(img: UIImageView, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat) {
        img.frame = CGRectMake(x, y, width, height)
    }
    
    func pokemonPressed(button: UIButton!) {
        if button.backgroundImageForState(UIControlState.Normal) == UIImage(named:"pokeball"){
            button.setBackgroundImage(nil, forState: UIControlState.Normal)
        } else {
            button.setBackgroundImage(UIImage(named: "pokeball"), forState: UIControlState.Normal)
        }
    }
    
    func updateButtonState(button: UIButton) {
        
    }

}
