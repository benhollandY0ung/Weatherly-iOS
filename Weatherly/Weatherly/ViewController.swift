//
//  ViewController.swift
//  Weatherly
//
//  Created by Ben Holland on 18/01/2015.
//  Copyright (c) 2015 Ben Holland. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tempValue: UILabel!
    
    
    
    //Replace the string below with your API Key.
    private let apiKey = "4de5319c1c8991a1ff2985013795b0b3"
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //refreshActivityIndicator.hidden = true
        
        getCurrentWeatherData()
    }
    
    func getCurrentWeatherData() -> Void {
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: "37.8267,-122.423", relativeToURL: baseURL)
        
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            if (error == nil) {
                let dataObject = NSData(contentsOfURL: location)
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary
                
                let currentWeather = Current(weatherDictionary: weatherDictionary)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    
                    //Stop refresh animation
                    //self.refreshActivityIndicator.stopAnimating()
                    //self.refreshActivityIndicator.hidden = true
                    //self.refreshButton.hidden = false
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
                    //self.refreshActivityIndicator.stopAnimating()
                    //self.refreshActivityIndicator.hidden = true
                    //self.refreshButton.hidden = false
                })
                
            }
            
        })
        
        downloadTask.resume()
    }
    
    
    @IBAction func refresh() {
        getCurrentWeatherData()
        
        //refreshButton.hidden = true
        //refreshActivityIndicator.hidden = false
        // refreshActivityIndicator.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

