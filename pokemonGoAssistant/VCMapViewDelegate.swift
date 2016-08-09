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
    
    func getAnnotations() -> [MKAnnotation] {
        let annotations = self.mapView.annotations
        return annotations
        //self.mapView.removeAnnotations(annotations)
    }
}