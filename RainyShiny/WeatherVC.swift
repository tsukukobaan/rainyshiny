//
//  WeatherVC.swift
//  RainyShiny
//
//  Created by 小林 泰 on 2017/03/11.
//  Copyright © 2017年 TokyoIceHockeyChannel. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            //print(currentLocation.coordinate.latitude,currentLocation.coordinate.longitude)
            //print(Location.sharedInstance.latitude,Location.sharedInstance.longitude)
            
            currentWeather.downLoadWeatherDetails {
                self.downLoadForecastData {
                    self.updateMainUI()
                    self.tableView.reloadData()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downLoadForecastData(completed: @escaping DownloadComplete) {
        //let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        print("parsing the list")
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print("parsed object")
                        print(obj)
                        print("obj end")
                        
                        print(FORECAST_URL)
                        print(CURRENT_WEATHER_URL)
                        
                    }
                    //self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell{
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
        
        
        
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        print(currentWeather.date)
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        print(currentWeather.currentTemp)
        currentWeatherTypeLabel.text = currentWeather.weatherType
        print("\(currentWeather.weatherType)")
        locationLabel.text = currentWeather.cityName
        print("\(currentWeather.cityName)")
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        print("end update UI")
    }

    
}
