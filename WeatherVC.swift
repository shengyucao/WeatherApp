//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Shengyu Cao on 5/9/17.
//  Copyright © 2017 Shengyu Cao. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var weatherTypeImage: UIImageView!
    
    @IBOutlet weak var weatherTable: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    var newCity: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        weatherTable.delegate = self
        weatherTable.dataSource = self
       
        currentWeather = CurrentWeather()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
            
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
            
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete){
        let forecastURL = URL(string: FORECAST_WEATHER_URL)
        
        Alamofire.request(forecastURL!).responseJSON { response in
            if let JSON = response.result.value as? [String:Any]{
                
                if let list = JSON["list"] as? [[String:Any]] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                    
                        self.forecasts.append(forecast)
                
                    }
                    self.forecasts.remove(at: 0) // remove first tableViewCell(today)
                    self.weatherTable.reloadData()
                }
            }
        completed()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else{
            return WeatherCell()
        }
    }
    
    func updateMainUI(){
        
        self.cityName.text = currentWeather.cityName
        self.weatherType.text = currentWeather.weatherType
        self.currentTemp.text = currentWeather.currentTemp
        self.todayDate.text = currentWeather.date
        self.weatherTypeImage.image = UIImage(named: currentWeather.weatherType)
    }
    

}

