//
//  CustomPointAnnotation.swift
//  pokemonGoAssistant
//
//  Created by Anthony Kim on 7/19/16.
//  Copyright © 2016 anthonykim. All rights reserved.
//

import UIKit
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var pinCustomImageName:String!
    var latitude:Double!
    var longitude:Double!
    var distance:Double!
    var address:String!
    var postedBy:String!
    var userRating:Int!
    var postRating:Int!
    var timePosted:Float!
    var like:Bool!
    var dislike:Bool!
}
