//
//  Constants.swift
//  RainyShiny
//
//  Created by 小林 泰 on 2017/03/11.
//  Copyright © 2017年 TokyoIceHockeyChannel. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="

let API_KEY = "f35f3d0731c14c2f250cb78dd7c125c5"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude)\(LONGITUDE)\(Location.sharedInstance.longitude)\(APP_ID)\(API_KEY)"

//let FORECAST_URL = "http://sample.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude)&lon=\(Location.sharedInstance.longitude)&cnt=10&appid=\(API_KEY)"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude)&lon=\(Location.sharedInstance.longitude)&cnt=10&appid=f35f3d0731c14c2f250cb78dd7c125c5"
