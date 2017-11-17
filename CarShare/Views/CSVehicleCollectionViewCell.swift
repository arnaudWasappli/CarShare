//
//  CSVehicleCollectionViewCell.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-14.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit
import Kingfisher

class CSVehicleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var representedAssetIdentifier: String!
    var vehicle: CSVehicle? {
        didSet {
            guard let vehicle = vehicle else {
                return
            }
            if let image = vehicle.thumbnail, let url = URL(string: image) {
                imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "car_placeholder"))
            } else {
                imageView.image = #imageLiteral(resourceName: "car_placeholder")
            }
            if let icon = vehicle.category?.iconString {
                categoryImageView.image = UIImage(named: icon)
            } else {
                categoryImageView.image = nil
            }
            nameLabel.text = vehicle.carName
            infoLabel.text = vehicle.carMainElementsString
            distanceLabel.text = vehicle.distance
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .white
        
        imageView.clipsToBounds      = true
        imageView.layer.cornerRadius = 4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = #imageLiteral(resourceName: "car_placeholder")
    }
}
