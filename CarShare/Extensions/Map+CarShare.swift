//
//  Map+CarShare.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-16.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import MapKit

extension CLLocation {
    
    static var parisCenter: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 48.858093, longitude: 2.294694)
    }
}

extension MKCoordinateRegion {
    
    static var parisRegion: MKCoordinateRegion {
        let parisCenter = CLLocation.parisCenter
        let delta: CLLocationDegrees = 0.9
        let parisSpan = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        return MKCoordinateRegion(center: parisCenter, span: parisSpan)
    }
}
