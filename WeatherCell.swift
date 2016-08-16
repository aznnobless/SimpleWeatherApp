//
//  WeatherCell.swift
//  SimpleWeather
//
//  Created by Byung Ho Lee on 8/15/16.
//  Copyright © 2016 Byunghl. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var minTemperatureLabel: UILabel!
    @IBOutlet var maxTemperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code here
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
