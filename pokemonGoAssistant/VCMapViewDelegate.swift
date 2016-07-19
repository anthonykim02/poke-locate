//
//  VCMapViewDelegate.swift
//  pokemonGoAssistant
//
//  Created by Kunal Desai on 7/18/16.
//  Copyright © 2016 anthonykim. All rights reserved.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let mapPoint = mapView.visibleMapRect
        let topLeftCoordinates = MKCoordinateForMapPoint(mapPoint.origin)
        let mapPointBottomRightX = MKMapRectGetMaxX(mapPoint)
        let mapPointBottomRightY = MKMapRectGetMaxY(mapPoint)
        let bottomRightCoordinates = MKCoordinateForMapPoint(MKMapPoint(x: mapPointBottomRightX, y: mapPointBottomRightY))
    }
}