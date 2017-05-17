//
//  Constants.swift
//  WeatherApp
//
//  Created by Shengyu Cao on 5/14/17.
//  Copyright © 2017 Shengyu Cao. All rights reserved.
//

import Foundation


let latitude = Location.sharedInstance.latitude!
let longtitude = Location.sharedInstance.longitude!
let apiKey = "9f4f6068b8971ab5afa80c152fd7bda8"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longtitude)&appid=\(apiKey)"

let FORECAST_WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(latitude)&lon=\(longtitude)&cnt=10&appid=\(apiKey)"
