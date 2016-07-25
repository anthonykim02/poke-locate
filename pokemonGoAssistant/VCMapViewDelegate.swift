//
//  VCMapViewDelegate.swift
//  pokemonGoAssistant
//
//  Created by Kunal Desai on 7/18/16.
//  Copyright © 2016 anthonykim. All rights reserved.
//

import Foundation
import MapKit
import Alamofire
import SwiftyJSON

extension ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let mapPoint = mapView.visibleMapRect
        let topLeftCoordinates = MKCoordinateForMapPoint(mapPoint.origin)
        let mapPointBottomRightX = MKMapRectGetMaxX(mapPoint)
        let mapPointBottomRightY = MKMapRectGetMaxY(mapPoint)
        let bottomRightCoordinates = MKCoordinateForMapPoint(MKMapPoint(x: mapPointBottomRightX, y: mapPointBottomRightY))
        let annotations = getAnnotations()
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
                            let time = report["timestamp"].floatValue
                            self.addPokemon(latitude, longitude: longitude, index: pokemon, timePosted: time)
                        }
                        self.mapView.removeAnnotations(annotations)
                    } else {
                        // error message
                    }
                    
                }
            }
    }
    
    func getAnnotations() -> [MKAnnotation] {
        let annotations = self.mapView.annotations
        return annotations
        //self.mapView.removeAnnotations(annotations)
    }
}