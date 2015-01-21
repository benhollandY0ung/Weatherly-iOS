//
//  Today.swift
//  Weatherly
//
//  Created by Ben Holland on 20/01/2015.
//  Copyright (c) 2015 Ben Holland. All rights reserved.
//
import Foundation
import UIKit

struct Today {
    
    
    
    var precipProbability: Double
    var summary: String
    var icon: UIImage?
    var visibility: Double
    //var sunsetTime: String?
    //var sunriseTime: String?
    
    
    init(weatherDictionary: NSDictionary) {
        let dailyWeather = weatherDictionary["daily"] as NSDictionary
        
        
        precipProbability = dailyWeather["precipProbability"] as Double
        summary = dailyWeather["summary"] as String
        visibility = dailyWeather["visibility"] as Double
        
        
        
        
       
        
        let iconString = dailyWeather["icon"] as String
        icon = weatherIconFromString(iconString)
        
        
        //let sunsetTimeFromString = dailyWeather["sunsetTime"] as String
        //sunsetTime = dateStringFromUnixTime(sunsetTimeFromString)
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
