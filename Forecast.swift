//
//  Forecast.swift
//  WeatherApp
//
//  Created by Shengyu Cao on 5/14/17.
//  Copyright © 2017 Shengyu Cao. All rights reserved.
//

import UIKit


class Forecast {

    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil{
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    
    init(weatherDict: [String : Any]){
        
        if let temp = weatherDict["temp"] as? [String : Any]{
            if let max = temp["max"] as? Double{
                let kelvinToFahrenheit = max * (9/5) - 459.67
                let fahrenheit = Double(round(kelvinToFahrenheit*10)/10)
                self._highTemp = "\(fahrenheit)"
                //print (self._highTemp)
            }
            
            if let min = temp["min"] as? Double {
                let kelvinToFahrenheit = min * (9/5) - 459.67
                let fahrenheit = Double(round(kelvinToFahrenheit*10)/10)
                self._lowTemp = "\(fahrenheit)"
                //print (self._lowTemp)
            }
            
        }
        if let weather = weatherDict["weather"] as? [[String : Any]] {
            if let main = weather[0]["main"] as? String  {
                self._weatherType = main
                //print(self._weatherType)
            }
        }
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
            //print(self._date)
        }
        
    }

}

extension Date {
    func dayOfTheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}






