//
//  CSVehicleAnnotation.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-15.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit
import MapKit

class CSVehicleAnnotation: MKPointAnnotation {

    var vehicle: CSVehicle
    var category: CSCategory
    
    public init(vehicle: CSVehicle) {
        self.vehicle = vehicle
        self.category = vehicle.category ?? .city
        
        super.init()
        self.coordinate = vehicle.coordinates
        self.title      = vehicle.carName
        self.subtitle   = vehicle.carMainElementsString
    }
}
