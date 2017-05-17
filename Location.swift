//
//  Location.swift
//  WeatherApp
//
//  Created by Shengyu Cao on 5/17/17.
//  Copyright © 2017 Shengyu Cao. All rights reserved.
//

import CoreLocation


class Location {
    static var sharedInstance = Location()
    
    private init() { }
    
    var latitude: Double!
    var longitude: Double!
    
    
}
