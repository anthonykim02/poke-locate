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
    let pokemonImage = UIImageView()
    let distance = UILabel()
    let location = UILabel()
    let user = UILabel()
    let userRate = UILabel()
    let postRate = UILabel()
    let likeButton = UIButton()
    let dislikeButton = UIButton()
    
    var selectedPokemon:String! = "pokemon name here"
    
    var nameData = ["bulbasaur", "ivysaur", "venusaur", "charmander", "charmeleon", "charizard", "squirtle", "wartortle", "blastoise", "caterpie", "metapod", "butterfree", "weedle", "kakuna", "beedrill", "pidgey", "pidgeotto", "pidgeot", "rattata", "raticate", "spearow", "fearow", "ekans", "arbok", "pikachu", "raichu", "sandshrew", "sandslash", "nidoran-f", "nidorina", "nidoqueen", "nidoran-m", "nidorino", "nidoking", "clefairy", "clefable", "vulpix", "ninetales", "jigglypuff", "wigglytuff", "zubat", "golbat", "oddish", "gloom", "vileplume", "paras", "parasect", "venonat", "venomoth", "diglett", "dugtrio", "meowth", "persian", "psyduck", "golduck", "mankey", "primeape", "growlithe", "arcanine", "poliwag", "poliwhirl", "poliwrath", "abra", "kadabra", "alakazam", "machop", "machoke", "machamp", "bellsprout", "weepinbell", "victreebel", "tentacool", "tentacruel", "geodude", "graveler", "golem", "ponyta", "rapidash", "slowpoke", "magnemite", "magneton", "farfetchd", "doduo", "dodrio", "seel", "dewgong", "grimer", "muk", "shellder", "cloyster", "gastly", "haunter", "gengar", "onix", "drowzee", "hypno", "krabby", "kingler", "voltorb", "electrode", "exeggcute", "exeggutor", "cubone", "marowak", "hitmonlee", "hitmonchan", "lickitung", "koffing", "weezing", "rhyhorn", "rhydon", "chansey", "tangela", "kangaskhan", "horsea", "seadra", "goldeen", "seaking", "staryu", "starmie", "mr-mime", "scyther", "jynx", "electabuzz", "magmar", "pinsir", "tauros", "magikarp", "gyarados", "lapras", "ditto", "eevee", "vaporeon", "jolteon", "flareon", "porygon", "omanyte", "omastar", "kabuto", "kabutops", "aerodactyl", "snorlax", "articuno","zapdos", "moltres", "dratini", "dragonair", "dragonite", "mewtwo", "mew"]
    
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    var numberUpdates = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.latitude = 0.0
        self.longitude = 0.0
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringSignificantLocationChanges()
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        
//        let shadowView = UIView(frame: CGRectMake(50, 50, 100, 100))
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("removePopUp:"))
        view.addGestureRecognizer(tap)
        
        let mapHeight = self.view.frame.size.height
        let mapWidth = self.view.frame.size.width
        
        pop.frame = CGRect(x: 0, y: 0, width: mapWidth, height: mapHeight / 3)
        pop.backgroundColor = UIColor.grayColor()
        pop.layer.cornerRadius = 5.0
        pop.layer.borderColor = UIColor.grayColor().CGColor
        pop.layer.borderWidth = 0.5
        
        pop.layer.shadowColor = UIColor.blackColor().CGColor
        pop.layer.shadowOffset = CGSize(width: 0, height: 3)
        pop.layer.shadowOpacity = 0.4
        pop.layer.shadowRadius = 4
        pop.hidden = true
        
        
        let pokeSize = CGSize(width: mapHeight / 8, height: mapHeight / 8)
        pokemonImage.frame = CGRect(x: (mapWidth / 2) - (pokeSize.width / 2), y: 0, width: pokeSize.width, height: pokeSize.height)
        
        let labelSize = CGSize(width: mapWidth / 2, height: mapHeight / 30)
        distance.frame = CGRect(x: (mapWidth / 2) - (labelSize.width / 2), y: pokemonImage.frame.maxY - (pokeSize.width / 8), width: labelSize.width, height: labelSize.height)
        location.frame = CGRect(x: (mapWidth / 2) - (labelSize.width / 2), y: distance.frame.maxY, width: labelSize.width, height: labelSize.height)
        user.frame = CGRect(x: mapWidth / 30, y: location.frame.maxY, width: labelSize.width, height: labelSize.height)
        userRate.frame = CGRect(x: mapWidth / 30, y: user.frame.maxY, width: labelSize.width, height: labelSize.height)
        postRate.frame = CGRect(x: mapWidth * 0.65, y: userRate.frame.maxY, width: labelSize.width, height: labelSize.height)
        
        distance.textAlignment = NSTextAlignment.Center
        location.textAlignment = NSTextAlignment.Center
        distance.text = "distance"
        location.text = "location"
        user.text = "user"
        userRate.text = "userRating"
        postRate.text = "userRate"
        
        let buttonSize = CGSize(width: mapWidth / 7, height: mapWidth / 7)
        likeButton.setImage(UIImage(named: "Thumbs Up"), forState: UIControlState.Normal)
        dislikeButton.setImage(UIImage(named: "Thumbs Down"), forState: UIControlState.Normal)
        
        likeButton.frame = CGRect(x: mapWidth * 0.65, y: (mapHeight / 3) - (buttonSize.width / 2), width: buttonSize.width, height: buttonSize.height)
        dislikeButton.frame = CGRect(x: likeButton.frame.maxX, y: (mapHeight / 3) - (buttonSize.width / 2), width: buttonSize.width, height: buttonSize.height)
        
        likeButton.hidden = true
        dislikeButton.hidden = true
        
        pop.addSubview(pokemonImage)
        pop.addSubview(distance)
        pop.addSubview(location)
        pop.addSubview(user)
        pop.addSubview(userRate)
        pop.addSubview(postRate)
        self.view.addSubview(pop)
        self.view.addSubview(likeButton)
        self.view.addSubview(dislikeButton)
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
        latitude = locValue.latitude
        longitude = locValue.longitude
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    @IBAction func tracked(sender: AnyObject) {
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Track")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    @IBAction func reported(sender: AnyObject) {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("Report") as! Report
        vc.latitude = latitude
        vc.longitude = longitude
        self.showViewController(vc, sender: vc)
    }
    
    @IBAction func refresh(sender: AnyObject) {
        refreshFunction()
    }
    
    func addPokemon(latitude: Double, longitude: Double, index: Int) {
        print(latitude)
        print(longitude)
        print(index)
        let pokemonName = nameData[index]
        print(pokemonName)
        let pokemon = CustomPointAnnotation()
        pokemon.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        pokemon.title = pokemonName
        pokemon.subtitle = "click for more info"
        pokemon.pinCustomImageName = pokemonName + ".png"
        
        self.mapView.addAnnotation(pokemon)
    }
    
    @IBAction func likeAction(sender: AnyObject) {
        print("like")
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        print("works", terminator: "")
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
        selectedPokemon = view.annotation!.title!
        pokemonImage.image = UIImage(named: selectedPokemon)
        pop.hidden = false
        likeButton.hidden = false
        dislikeButton.hidden = false
    }
    
    func refreshFunction() {
        let mapPoint = mapView.visibleMapRect
        let topLeftCoordinates = MKCoordinateForMapPoint(mapPoint.origin)
        let mapPointBottomRightX = MKMapRectGetMaxX(mapPoint)
        let mapPointBottomRightY = MKMapRectGetMaxY(mapPoint)
        let bottomRightCoordinates = MKCoordinateForMapPoint(MKMapPoint(x: mapPointBottomRightX, y: mapPointBottomRightY))
        Alamofire.request(.GET, "http://pokemongo-dev.us-west-1.elasticbeanstalk.com/api/reports/filter", parameters: ["top_left_latitude" : topLeftCoordinates.latitude, "top_left_longitude" : topLeftCoordinates.longitude, "bottom_right_latitude": bottomRightCoordinates.latitude, "bottom_right_longitude": bottomRightCoordinates.longitude]).validate()
            .responseJSON{ (_, _, response) in
                print(response.value)
                if let json = response.value {
                    let data = JSON(json)
                    if data["success"] == 0 {
                        let reports = data["reports"].arrayValue
                        for report in reports {
                            let latitude = report["latitude"].doubleValue
                            let longitude = report["longitude"].doubleValue
                            let pokemon = report["pokemon"].intValue
                            self.addPokemon(latitude, longitude: longitude, index: pokemon)
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
        if !CGRectContainsPoint(updatedBounds, point) {
            pop.hidden = true
            likeButton.hidden = true
            dislikeButton.hidden = true
        }
        
    }
    
}


