//
//  Current.swift
//  Weatherly
//
//  Created by Ben Holland on 18/01/2015.
//  Copyright (c) 2015 Ben Holland. All rights reserved.
//

import Foundation
import UIKit

struct Current {
    
    var currentTime: String?
    var temperature: Int
    var humidity: Double
    var precipProbability: Double
    var summary: String
    var icon: UIImage?
    var ozone: Double
    var pressure: Double
    var visibility: Double
    var windSpeed: Double
    var cloudCover: Double
    //var nearestStorm: Double
    
    init(weatherDictionary: NSDictionary) {
        let currentWeather = weatherDictionary["currently"] as NSDictionary
        
        temperature = currentWeather["temperature"] as Int
        humidity = currentWeather["humidity"] as Double
        precipProbability = currentWeather["precipProbability"] as Double
        summary = currentWeather["summary"] as String
        ozone = currentWeather["ozone"] as Double
        pressure = currentWeather["pressure"] as Double
        visibility = currentWeather["visibility"] as Double
        windSpeed = currentWeather["windSpeed"] as Double
        //nearestStorm = currentWeather["nearestStorm"] as Double
        cloudCover = currentWeather["cloudCover"] as Double
        
        let currentTimeIntVale = currentWeather["time"] as Int
        currentTime = dateStringFromUnixTime(currentTimeIntVale)
        
        let iconString = currentWeather["icon"] as String
        icon = weatherIconFromString(iconString)
    }
    
    
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    func weatherIconFromString(stringIcon: String) -> UIImage {
        var imageName: String
        
        switch stringIcon {
        case "clear-day":
            imageName = "clear-day"
        case "clear-night":
            imageName = "clear-night"
        case "rain":
            imageName = "rain"
        case "snow":
            imageName = "snow"
        case "sleet":
            imageName = "sleet"
        case "wind":
            imageName = "wind"
        case "fog":
            imageName = "fog"
        case "cloudy":
            imageName = "cloudy"
        case "partly-cloudy-day":
            imageName = "partly-cloudy"
        case "partly-cloudy-night":
            imageName = "cloudy-night"
        default:
            imageName = "default"
        }
        
        var iconName = UIImage(named: imageName)
        return iconName!
    }
    
}
