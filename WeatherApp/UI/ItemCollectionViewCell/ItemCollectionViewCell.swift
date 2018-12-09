//
//  ItemCollectionViewCell.swift
//  WeatherApp
//
//  Created by itstudiodev on 12/5/18.
//  Copyright © 2018 alexey bezrodniy. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var descriptionLabel:UILabel!
    @IBOutlet weak var degreesLabel:UILabel!
    @IBOutlet weak var timeLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(_ item:Item) {
        descriptionLabel.text = item.weatherDescription
        degreesLabel.text = item.degrees
        timeLabel.text = item.date
    }
    
    func setup(description:String, degrees:String, date:String) {
        descriptionLabel.text = description
        degreesLabel.text = degrees
        timeLabel.text = date
    }
    
    override func prepareForReuse() {
        descriptionLabel.text = ""
        degreesLabel.text = ""
        timeLabel.text = ""
    }
}
