//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Shengyu Cao on 5/17/17.
//  Copyright © 2017 Shengyu Cao. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!

    func configureCell(forecast : Forecast){
        self.dateLabel.text = forecast.date
        self.weatherType.text = forecast.weatherType
        self.highTemp.text = forecast.highTemp
        self.lowTemp.text = forecast.lowTemp
        self.weatherIcon.image = UIImage(named: forecast.weatherType)
    }

}
