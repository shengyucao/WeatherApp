//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Shengyu Cao on 5/14/17.
//  Copyright © 2017 Shengyu Cao. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType : String!
    var _currentTemp: String!
    
    var cityName: String {
        if _cityName == nil{
            _cityName = "Template City"
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            if let JSON = response.result.value as? [String : Any] {
                if let name = JSON["name"] as? String {
                    self._cityName = name.capitalized
                    //print(self._cityName)
                }
                if let weather = JSON["weather"] as? [[String : Any]] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        //print(self._weatherType)
                    }
                }
                if let main = JSON["main"] as? [String : Any] {
                    if let temp = main["temp"] as? Double{
                        let kelvinToFahrenheit = temp * (9/5) - 459.67
                        let rounding = Double(round(kelvinToFahrenheit*10)/10)
                        self._currentTemp = "\(rounding) °F"
                        //print (self._currentTemp)
                    }
                }
                
            }
            completed()
        }
        
    }
    
}
