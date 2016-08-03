    //
//  ViewController.swift
//  pokemonGoAssistant
//
//  Created by Anthony Kim on 7/15/16.
//  Copyright (c) 2016 anthonykim. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var report: UIButton!
    
    let pop = UIView()
    let shadow = UIView()
    let pokemonImage = UIImageView()
    let time = UILabel()
    let distance = UILabel()
    let location = UILabel()
    let user = UILabel()
    let userRate = UILabel()
    let postRate = UILabel()
    let likeButton = CustomButton()
    let dislikeButton = CustomButton()
    
    var mapHeight:CGFloat = 0.0
    var mapWidth:CGFloat = 0.0
    
    var popUpHeight:CGFloat = 0.0
    
    var selectedPokemon:String! = "pokemon name here"
    var popOut = false
    
    var nameData = ["bulbasaur", "ivysaur", "venusaur", "charmander", "charmeleon", "charizard", "squirtle", "wartortle", "blastoise", "caterpie", "metapod", "butterfree", "weedle", "kakuna", "beedrill", "pidgey", "pidgeotto", "pidgeot", "rattata", "raticate", "spearow", "fearow", "ekans", "arbok", "pikachu", "raichu", "sandshrew", "sandslash", "nidoran-f", "nidorina", "nidoqueen", "nidoran-m", "nidorino", "nidoking", "clefairy", "clefable", "vulpix", "ninetales", "jigglypuff", "wigglytuff", "zubat", "golbat", "oddish", "gloom", "vileplume", "paras", "parasect", "venonat", "venomoth", "diglett", "dugtrio", "meowth", "persian", "psyduck", "golduck", "mankey", "primeape", "growlithe", "arcanine", "poliwag", "poliwhirl", "poliwrath", "abra", "kadabra", "alakazam", "machop", "machoke", "machamp", "bellsprout", "weepinbell", "victreebel", "tentacool", "tentacruel", "geodude", "graveler", "golem", "ponyta", "rapidash", "slowpoke", "slowbro", "magnemite", "magneton", "farfetchd", "doduo", "dodrio", "seel", "dewgong", "grimer", "muk", "shellder", "cloyster", "gastly", "haunter", "gengar", "onix", "drowzee", "hypno", "krabby", "kingler", "voltorb", "electrode", "exeggcute", "exeggutor", "cubone", "marowak", "hitmonlee", "hitmonchan", "lickitung", "koffing", "weezing", "rhyhorn", "rhydon", "chansey", "tangela", "kangaskhan", "horsea", "seadra", "goldeen", "seaking", "staryu", "starmie", "mr-mime", "scyther", "jynx", "electabuzz", "magmar", "pinsir", "tauros", "magikarp", "gyarados", "lapras", "ditto", "eevee", "vaporeon", "jolteon", "flareon", "porygon", "omanyte", "omastar", "kabuto", "kabutops", "aerodactyl", "snorlax", "articuno","zapdos", "moltres", "dratini", "dragonair", "dragonite", "mewtwo", "mew"]
    
    let locationManager = CLLocationManager()
    var userLat = 0.0
    var userLon = 0.0
    var numberUpdates = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userLat = 0.0
        self.userLon = 0.0
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringSignificantLocationChanges()
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("removePopUp:"))
        view.addGestureRecognizer(tap)
        
        mapHeight = self.view.frame.size.height
        mapWidth = self.view.frame.size.width
        
        popUpHeight = mapHeight * 0.3
        
        // y starts above the screen for animation
        pop.frame = CGRect(x: 0, y: 0 - popUpHeight, width: mapWidth, height: popUpHeight)
        pop.backgroundColor = UIColor().HexToColor("#545c67 ", alpha: 1.0)
        pop.layer.cornerRadius = 5.0
        pop.layer.borderColor = UIColor.grayColor().CGColor
        pop.layer.borderWidth = 0.5
        
        pop.layer.shadowColor = UIColor.blackColor().CGColor
        pop.layer.shadowOffset = CGSize(width: 0, height: 3)
        pop.layer.shadowOpacity = 0.4
        pop.layer.shadowRadius = 4
        
        shadow.frame = CGRect(x: 0, y: 0, width: mapWidth, height: mapHeight)
        shadow.backgroundColor = UIColor.blackColor()
        shadow.alpha = 0
        
        
        
        let pokeSize = CGSize(width: mapHeight / 8, height: mapHeight / 8)
        pokemonImage.frame = CGRect(x: (mapWidth / 2) - (pokeSize.width / 2), y: 0, width: pokeSize.width, height: pokeSize.height)
        
        let labelSize = CGSize(width: mapWidth * 0.75, height: mapHeight / 30)
        let labelColor = UIColor().HexToColor("#f8f3eb", alpha: 1.0)
        time.frame = CGRect(x: mapWidth / 30, y: mapHeight / 40, width: labelSize.width, height: mapHeight / 40)
        distance.frame = CGRect(x: (mapWidth / 2) - (labelSize.width / 2), y: pokemonImage.frame.maxY - (pokeSize.width / 8), width: labelSize.width, height: labelSize.height)
        location.frame = CGRect(x: (mapWidth / 2) - (labelSize.width / 2), y: distance.frame.maxY, width: labelSize.width, height: labelSize.height)
        userRate.frame = CGRect(x: mapWidth / 30, y: popUpHeight - (mapHeight / 20), width: labelSize.width, height: mapHeight / 40)
        user.frame = CGRect(x: mapWidth / 30, y: userRate.frame.minY - (mapHeight / 40), width: labelSize.width, height: mapHeight / 40)
        postRate.frame = CGRect(x: mapWidth * 0.65, y: user.frame.minY, width: labelSize.width, height: mapHeight / 40)
        
        distance.textAlignment = NSTextAlignment.Center
        location.textAlignment = NSTextAlignment.Center
        
        time.font = UIFont(name: "Aleo-Regular", size: mapHeight / 52)
        distance.font = UIFont(name: "Aleo-Regular", size: mapHeight / 30)
        location.font = UIFont(name: "Aleo-Regular", size: mapHeight / 45)
        user.font = UIFont(name: "Aleo-Regular", size: mapHeight / 52)
        userRate.font = UIFont(name: "Aleo-Regular", size: mapHeight / 52)
        postRate.font = UIFont(name: "Aleo-Regular", size: mapHeight / 52)
        
        time.textColor = labelColor
        distance.textColor = labelColor
        location.textColor = labelColor
        user.textColor = labelColor
        userRate.textColor = labelColor
        postRate.textColor = labelColor
    
        time.text = "6 hours ago"
        distance.text = "0.5 miles away"
        location.text = "at Brower Court, San Ramon"
        user.text = "Submitted by AntMan623"
        userRate.text = "User's Current Rating: 65%"
        postRate.text = "Current Rating: 80%"
        
        let buttonSize = CGSize(width: mapWidth / 7, height: mapWidth / 7)
        likeButton.setImage(UIImage(named: "Thumbs Up"), forState: UIControlState.Normal)
        dislikeButton.setImage(UIImage(named: "Thumbs Down"), forState: UIControlState.Normal)
 
        likeButton.frame = CGRect(x: mapWidth * 0.65 + (buttonSize.width / 2), y: popUpHeight, width: 0, height: 0)
        dislikeButton.frame = CGRect(x: likeButton.frame.maxX + (buttonSize.width / 2), y: popUpHeight, width: 0, height: 0)
        
        likeButton.addTarget(self, action: Selector("likeAction:"),forControlEvents: .TouchUpInside)
        dislikeButton.addTarget(self, action: Selector("likeAction:"), forControlEvents: .TouchUpInside)
        
        pop.addSubview(pokemonImage)
        pop.addSubview(time)
        pop.addSubview(distance)
        pop.addSubview(location)
        pop.addSubview(user)
        pop.addSubview(userRate)
        pop.addSubview(postRate)
        self.view.addSubview(pop)
        self.view.addSubview(shadow)
        self.view.addSubview(likeButton)
        self.view.addSubview(dislikeButton)
        self.view.bringSubviewToFront(shadow)
        self.view.bringSubviewToFront(pop)
        self.view.bringSubviewToFront(likeButton)
        self.view.bringSubviewToFront(dislikeButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        if numberUpdates == 0 {
            let center = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
            self.mapView.setRegion(region, animated: true)
        } else {
            
        }
        numberUpdates = numberUpdates + 1
        userLat = locValue.latitude
        userLon = locValue.longitude
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location Error: " + error.localizedDescription)
    }
    
    @IBAction func tracked(sender: AnyObject) {
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("VCTracking")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    @IBAction func reported(sender: AnyObject) {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("Report") as! Report
        vc.latitude = userLat
        vc.longitude = userLon
        self.showViewController(vc, sender: vc)
    }
    
    @IBAction func refresh(sender: AnyObject) {
        refreshFunction()
    }
    
    func addPokemon(latitude: Double, longitude: Double, index: Int, timePosted: Float) {
        let pokemonName = nameData[index]
        let pokemon = CustomPointAnnotation()
        pokemon.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        pokemon.pinCustomImageName = pokemonName + ".png"
        pokemon.latitude = latitude
        pokemon.longitude = longitude
        pokemon.title = pokemonName.capitalizedString
        pokemon.subtitle = "click for more info"
        pokemon.like = false
        pokemon.dislike = false
        
        let userLocation = CLLocation(latitude: userLat, longitude: userLon)
        let aLocation = CLLocation(latitude: latitude, longitude: longitude)
        pokemon.distance = Double(round(10 * (userLocation.distanceFromLocation(aLocation) * 0.000621371))/10)
        
        pokemon.timePosted = timePosted
        
        CLGeocoder().reverseGeocodeLocation(aLocation, completionHandler: { (placemarks, error) -> Void in
            
            if error != nil
            {
                print("Geocode Error: " + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0
            {
                let pm = placemarks![0] as! CLPlacemark
                var address:String = ""
                if pm.thoroughfare != nil && pm.locality != nil {
                    address = pm.thoroughfare! + ", " + pm.locality!
                }
                pokemon.address = address
            }
        })
        
        self.mapView.addAnnotation(pokemon)
    }
    
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
            anView!.leftCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            anView!.annotation = annotation
        }
        
        let cpa = annotation as! CustomPointAnnotation
        anView!.image = UIImage(named: cpa.pinCustomImageName)
        
        return anView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        selectedPokemon = view.annotation!.title!!.lowercaseString
        pokemonImage.image = UIImage(named: selectedPokemon)
        popOut = true
//        likeButton.hidden = false
//        dislikeButton.hidden = false
        
//        let userLocation = CLLocation(latitude: userLat, longitude: userLon)
//        let aLocation = CLLocation(latitude: view.annotation!.coordinate.latitude, longitude: view.annotation!.coordinate.longitude)
//        let milesAway = Double(round(10 * (userLocation.distanceFromLocation(aLocation) * 0.000621371))/10)
//        let text = String(format: "%.1f", arguments: [milesAway])
//        distance.text = text + " miles away"
        
        
        let cpa = view.annotation as? CustomPointAnnotation
        
        
        let currentTime = Float(NSDate().timeIntervalSince1970)
        let elapsedTime = (currentTime - cpa!.timePosted)
        var duration = Int(elapsedTime)
        if duration < 60 {
            time.text = String(duration) + " second(s) ago"
        }
        else if duration >= 86400 {
            duration = Int(duration / 86400)
            time.text = String(duration) + " day(s) ago"
        }
        else if duration >= 3600 {
            duration = Int(duration / 3600)
            time.text = String(duration) + " hour(s) ago"
        }
        else {
            duration = Int(duration / 60)
            time.text = String(duration) + " minute(s) ago"
        }
        
        
        let userLocation = CLLocation(latitude: userLat, longitude: userLon)
        let aLocation = CLLocation(latitude: cpa!.latitude, longitude: cpa!.longitude)
        cpa!.distance = Double(round(10 * (userLocation.distanceFromLocation(aLocation) * 0.000621371))/10)
        let text = String(format: "%.1f", arguments:[cpa!.distance])
        distance.text = text + " miles away"
        
        if cpa!.address != nil {
            location.text = "at " + cpa!.address
        }
        else {
            location.text = ""
        }
        
        
        let xCoord = pop.frame.origin.x
        let yCoord = pop.frame.maxY
        let aHeight = pop.frame.size.height
        let aWidth = pop.frame.size.width
        
        let buttonSize = CGSize(width: mapWidth / 7, height: mapWidth / 7)
        likeButton.view = view
        dislikeButton.view = view
        
        if cpa!.like == true {
            likeButton.setImage(UIImage(named: "Thumbs Up highlight"), forState: UIControlState.Normal)
        }
        else {
            likeButton.setImage(UIImage(named: "Thumbs Up"), forState: UIControlState.Normal)
        }
        
        if cpa!.dislike == true {
            dislikeButton.setImage(UIImage(named: "Thumbs Down highlight"), forState: UIControlState.Normal)
        }
        else {
            dislikeButton.setImage(UIImage(named: "Thumbs Down"), forState: UIControlState.Normal)
        }
        
        UIView.animateWithDuration(0.4, animations: {
            self.pop.frame = CGRectMake(xCoord, yCoord, aWidth, aHeight)
            self.shadow.alpha = 0.5
        })
        UIButton.animateWithDuration(0.4, animations: {
            self.likeButton.frame = CGRect(x: self.mapWidth * 0.65, y: self.popUpHeight - (buttonSize.width / 2), width: buttonSize.width, height: buttonSize.height)
            self.dislikeButton.frame = CGRect(x: self.likeButton.frame.maxX, y: self.popUpHeight - (buttonSize.width / 2), width: buttonSize.width, height: buttonSize.height)
            
        })
        
        
        
        
    }
    
    func likeAction(sender: CustomButton!) {
        let cpa = sender.view.annotation as? CustomPointAnnotation
        if sender == likeButton {
            sender.setImage(UIImage(named: "Thumbs Up highlight"), forState: UIControlState.Normal)
        }
        else {
            sender.setImage(UIImage(named: "Thumbs Down highlight"), forState: UIControlState.Normal)
        }
        
        
        if cpa!.like == true && sender == likeButton {
            likeButton.setImage(UIImage(named: "Thumbs Up"), forState: UIControlState.Normal)
            cpa!.like = false
        }
        else if cpa!.dislike == true && sender == dislikeButton {
            dislikeButton.setImage(UIImage(named: "Thumbs Down"), forState: UIControlState.Normal)
            cpa!.dislike = false
        }
        else {
            if cpa!.like == true && sender == dislikeButton {
                likeButton.setImage(UIImage(named: "Thumbs Up"), forState: UIControlState.Normal)
                cpa!.like = false
            }
            else if cpa!.dislike == true && sender == likeButton {
                dislikeButton.setImage(UIImage(named: "Thumbs Down"), forState: UIControlState.Normal)
                cpa!.dislike = false
            }
            
            if sender == dislikeButton {
                cpa!.dislike = true
            }
            else if sender == likeButton {
                cpa!.like = true
            }
        }
        
        
    }
    
    func refreshFunction() {
        let mapPoint = mapView.visibleMapRect
        let topLeftCoordinates = MKCoordinateForMapPoint(mapPoint.origin)
        let mapPointBottomRightX = MKMapRectGetMaxX(mapPoint)
        let mapPointBottomRightY = MKMapRectGetMaxY(mapPoint)
        let bottomRightCoordinates = MKCoordinateForMapPoint(MKMapPoint(x: mapPointBottomRightX, y: mapPointBottomRightY))
        Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/reports/filter", parameters: ["top_left_latitude" : topLeftCoordinates.latitude, "top_left_longitude" : topLeftCoordinates.longitude, "bottom_right_latitude": bottomRightCoordinates.latitude, "bottom_right_longitude": bottomRightCoordinates.longitude]).validate()
            .responseJSON{ (_, _, response) in
                if let json = response.value {
                    let data = JSON(json)
                    if data["success"] == 0 {
                        let reports = data["reports"].arrayValue
                        for report in reports {
                            let latitude = report["latitude"].doubleValue
                            let longitude = report["longitude"].doubleValue
                            let pokemon = report["pokemon"].intValue
                            let time = report["time"].floatValue
                            self.addPokemon(latitude, longitude: longitude, index: pokemon, timePosted: time)
                        }
                    } else {
                        // error message
                    }
                    
                }
        }
    }
    
    func removePopUp(tap: UITapGestureRecognizer) {
        var point = tap.locationInView(self.view)
        point = self.pop.convertPoint(point, fromView:self.view)
        let updatedBounds = CGRect(x: self.pop.bounds.minX, y: self.pop.bounds.minY, width: self.pop.bounds.width, height: self.pop.bounds.height + (likeButton.frame.height / 2))
        if !CGRectContainsPoint(updatedBounds, point) && popOut == true {
            let xCoord = pop.frame.origin.x
            let yCoord = 0 - pop.frame.maxY
            let aWidth = pop.frame.size.width
            let aHeight = pop.frame.size.height
            
            let buttonSize = CGSize(width: mapWidth / 7, height: mapWidth / 7)
            
            UIView.animateWithDuration(0.5, animations: {
                self.pop.frame = CGRectMake(xCoord, yCoord, aWidth, aHeight)
                self.shadow.alpha = 0
            })
//            likeButton.hidden = true
//            dislikeButton.hidden = true
            UIButton.animateWithDuration(0.5, animations: {
                self.likeButton.frame = CGRect(x: self.mapWidth * 0.65 + (buttonSize.width / 2), y: self.popUpHeight, width: 0, height: 0)
                self.dislikeButton.frame = CGRect(x: self.likeButton.frame.maxX + (buttonSize.width / 2), y: self.popUpHeight, width: 0, height: 0)
                
            })
            popOut = false
            
        }
        
    }
    
}

extension UIColor{
    func HexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: NSScanner = NSScanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersInString: "#")
        // Scan hex value
        scanner.scanHexInt(&hexInt)
        return hexInt
    }
}


