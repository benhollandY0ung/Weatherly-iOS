//
//  ViewController.swift
//  Weatherly
//
//  Created by Ben Holland on 18/01/2015.
//  Copyright (c) 2015 Ben Holland. All rights reserved.
//


import UIKit
import CoreLocation

//TODO 
// ADD LOCATION DETECTION



class ViewController: UIViewController {
   
  
    
    @IBOutlet weak var tempValue: UILabel!
    @IBOutlet weak var summaryValue: UILabel!
    @IBOutlet weak var ozoneValue: UILabel!
    @IBOutlet weak var windValue: UILabel!
    @IBOutlet weak var humidityValue: UILabel!
    @IBOutlet weak var pressureValue: UILabel!
    @IBOutlet weak var visibilityValue: UILabel!
    @IBOutlet weak var precipitationValue: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nearestStormValue: UILabel!
    
    
    
    
    //Replace the string below with your API Key.
    let apiKey = "e7ad7026728abc35fce4c397fd5405d6"
    
    
     
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshActivityIndicator.hidden = true
        
       
        
       
        
        
        getCurrentWeatherData()
        
        
        
      
    }
    
   
    
    func getCurrentWeatherData() -> Void {
        
        var locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        var currentLocation = CLLocation!
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
                
                currentLocation = locManager.location
                
        }
        
      
        
     
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: "51.5171,-0.1062?units=si", relativeToURL: baseURL)
        
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            if (error == nil) {
                let dataObject = NSData(contentsOfURL: location)
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary
                
                let currentWeather = Current(weatherDictionary: weatherDictionary)
                
                
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    
                    self.tempValue.text = "\(currentWeather.temperature)"
                    self.summaryValue.text = "\(currentWeather.summary)"
                    self.ozoneValue.text = "\(currentWeather.ozone)"
                    self.windValue.text = "\(currentWeather.windSpeed)kmph"
                    self.humidityValue.text = "\(currentWeather.humidity)"
                    self.pressureValue.text = "\(currentWeather.pressure)"
                    self.visibilityValue.text = "\(currentWeather.visibility)km"
                    self.precipitationValue.text = "\(currentWeather.precipProbability)"
                    self.icon.image = currentWeather.icon!
                    //self.nearestStormValue.text = "\(currentWeather.nearestStorm)km"
                        
                    
                    
                    //Stop refresh animation
                    self.refreshActivityIndicator.stopAnimating()
                    self.refreshActivityIndicator.hidden = true
                    self.refreshButton.hidden = false
                })
                
            }
            else {
                
                let networkIssueController = UIAlertController(title: "Error", message: "Unable to load data. Connectivity error!", preferredStyle: .Alert)
                
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                networkIssueController.addAction(okButton)
                
                let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                networkIssueController.addAction(cancelButton)
                
                
                self.presentViewController(networkIssueController, animated: true, completion: nil)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //Stop refresh animation
                    self.refreshActivityIndicator.stopAnimating()
                    self.refreshActivityIndicator.hidden = true
                    self.refreshButton.hidden = false
                })
                
            }
            
        })
        
        downloadTask.resume()
    }
    
   
    @IBAction func refresh() {
        
        getCurrentWeatherData()
        
        refreshButton.hidden = true
        refreshActivityIndicator.hidden = false
        refreshActivityIndicator.startAnimating()

    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    
    
}

