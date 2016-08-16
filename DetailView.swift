//
//  DetailView.swift
//  SimpleWeather
//
//  Created by Byung Ho Lee on 8/15/16.
//  Copyright © 2016 Byunghl. All rights reserved.
//

import UIKit

class DetailView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var currentTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var weatherImageLabel: UIImageView!
    
    var rawInformation:AnyObject? = nil
    let detailInfoKey:[String] = ["Pressure", "Humidity", "Wind(speed/deg)"]
    var detailInfo:[String:String] = [:]
    @IBOutlet var weatherImageView: UIImageView!
    
    @IBOutlet var cityLabel: UILabel!
    
    @IBOutlet var countryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailInfo[detailInfoKey[0]] = String(rawInformation!["main"]!!["pressure"]!!)
        detailInfo[detailInfoKey[1]] = String(rawInformation!["main"]!!["humidity"]!!)
        detailInfo[detailInfoKey[2]] = String(format: "%d / %d", (rawInformation!["wind"]!!["speed"]!! as? Int)! , (rawInformation!["wind"]!!["deg"]!! as? Int)!)
        
        cityNameLabel.text = rawInformation!["name"] as? String
        currentTempLabel.text = String((rawInformation!["main"]!!["temp"]!! as? Float)!)
        minTempLabel.text = String((rawInformation!["main"]!!["temp_min"]!! as? Float)!)
        maxTempLabel.text = String((rawInformation!["main"]!!["temp_max"]!! as? Float)!)
        descriptionLabel.text = rawInformation!["weather"]!![0]["description"]!! as? String
        let currentWeather = rawInformation!["weather"]!![0]["main"]!! as? String
        weatherImageLabel!.image = UIImage(named: MasterViewController.weatherImageMap[currentWeather!.lowercaseString]!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailInfoKey.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = detailInfoKey[indexPath.row]
        cell.detailTextLabel?.text = detailInfo[detailInfoKey[indexPath.row]]
        
        return cell
    }


}
