//
//  WeatherCell.swift
//  RainyShiny
//
//  Created by 小林 泰 on 2017/03/12.
//  Copyright © 2017年 TokyoIceHockeyChannel. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!

    func configureCell(forecast: Forecast) {
        lowLabel.text = forecast.lowTemp
        highLabel.text = forecast.highTemp
        weatherTypeLabel.text = forecast.weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType)
        dayLabel.text = forecast.date
    }

}
