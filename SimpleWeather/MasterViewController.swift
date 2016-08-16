//
//  MasterViewController.swift
//  SimpleWeather
//
//  Created by Byung Ho Lee on 8/15/16.
//  Copyright © 2016 Byunghl. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    static let weatherImageMap:[String:String] = ["clear":"sunny.png", "snow": "snow.png", "blizzard":"blizzard", "clouds":"cloudy.png","haze":"cloudy.png", "mist":"cloudy.png", "rain":"rainy.png"]
    
    var rawData = NSDictionary()
    var listData = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func parseJSON() {
        let apiKey = "538988c2fa8dc7e8ee69f04c06bf0c71" // TODO : TRY TO HIDE THIS VALUE RIGHT HERE
        let baseURL = NSURL(string: "http://api.openweathermap.org/data/2.5/box/city?bbox=-118,34,-117,33,10&cluster=yes&&APPID=\(apiKey)")
        
        do {
            self.rawData = try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfURL:baseURL!)!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        } catch {
           print("Error loading data")
        }
        
        listData = rawData["list"] as! [AnyObject]
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rawData["cnt"] as! Int!
    }
    
    /* 
     *  TODO : This code need to be refactored 
     *      - Try to elminate hard coding
     *      - JSON manipulation is rough
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! WeatherCell
        
        let current = listData[indexPath.row]
        let curentWeather = current["weather"]!![0]["main"]!! as? String
        
        cell.imageView!.image = UIImage(named: MasterViewController.weatherImageMap[curentWeather!.lowercaseString]!)
        cell.cityLabel.text = (current["name"] as! String)
        cell.descriptionLabel.text = current["weather"]!![0]["description"]!! as? String
        cell.temperatureLabel.text = String(format: "%.00f °C", (current["main"]!!["temp"]!! as? Float)!)
        cell.minTemperatureLabel.text = String(format: "%.00f °C", (current["main"]!!["temp_min"]!! as? Float)!)
        cell.maxTemperatureLabel.text = String(format: "%.00f °C", (current["main"]!!["temp_max"]!! as? Float)!)
        
        print(listData[0])
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailWeather" {
            let detailViewController : DetailView = segue.destinationViewController as! DetailView
            detailViewController.rawInformation = listData[(self.tableView.indexPathForSelectedRow!).row]
        }
    }

}


