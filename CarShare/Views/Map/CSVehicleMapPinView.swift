//
//  CSVehicleMapPinView.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-15.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit
import MapKit

class CSVehicleMapPinView: MKMarkerAnnotationView {

    override var annotation: MKAnnotation? {
        willSet {
            if let vehicle = newValue as? CSVehicleAnnotation {
                clusteringIdentifier = "category"// vehicle.category.rawValue //"category"
                glyphImage           = UIImage(named: vehicle.category.iconString)
                markerTintColor      = UIColor.csTurquoiseColor
                displayPriority      = .defaultLow
                titleVisibility      = .adaptive
                animatesWhenAdded    = true
            }
        }
    }
}
