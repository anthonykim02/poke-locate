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


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var report: UIButton!
    
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
        
        addPokemon(37.774468, longitude: -121.909371, index: 4)
        
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
    
    func addPokemon(latitude: Double, longitude: Double, index: Int) {
        print(latitude)
        print(longitude)
        print(index)
        let pokemonName = nameData[index]
        print(pokemonName)
        let pokemon = CustomPointAnnotation()
        pokemon.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        pokemon.title = pokemonName
        pokemon.subtitle = "hello"
        pokemon.pinCustomImageName = pokemonName + ".png"
        
        self.mapView.addAnnotation(pokemon)
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
        }
        else {
            anView!.annotation = annotation
        }
        
        let cpa = annotation as! CustomPointAnnotation
        anView!.image = UIImage(named: cpa.pinCustomImageName)
        
        return anView
    }
    
    
}


