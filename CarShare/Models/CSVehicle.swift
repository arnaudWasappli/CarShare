//
//  CSVehicle.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-14.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit
import CoreLocation

public struct CSVehicleList: Codable {
    let vehicles: [CSVehicle]
}

public struct CSVehicle: Codable {

    public var itemID      : Int64?
    public var addressID   : Int64?
    public var year        : Int?
    public var doorsCount  : Int?
    public var placesCount : Int?
    public var fuelType    : CSFuelType?
    public var gearsType   : CSGearType?
    public var model       : String?
    public var brand       : String?
    public var category    : CSCategory?
    public var thumbnail   : String?
    private var _distance  : String?
    public var latitude    : CLLocationDistance?
    public var longitude   : CLLocationDistance?
    
    enum CodingKeys: String, CodingKey {
        case itemID      = "id"
        case addressID   = "address_id"
        case year
        case doorsCount  = "doors_count"
        case placesCount = "places_count"
        case fuelType    = "fuel_type_cd"
        case gearsType   = "gears_type_cd"
        case model       = "vehicle_model"
        case brand
        case category
        case thumbnail   = "thumbnail_url"
        case _distance   = "distance_string"
        case latitude    = "fake_latitude"
        case longitude   = "fake_longitude"
    }
}

extension CSVehicle {
    
    var distance: String? {
        return _distance?.cleanString
    }
    
    var description: String {
        return "\(itemID ?? -1) -> \(brand ?? "unknown") \(model ?? "unknown") - \(category?.displayString ?? "No category")"
    }
    
    var searchString: String {
        var components = [String]()
        components.append(carName)
        if let cat      = category { components.append(cat.displayString) }
        if let distance = distance { components.append(distance) }
        if let count    = doorsCount { components.append("\(count) \("portes".localized)") }
        if let count    = placesCount { components.append("\(count) \("sièges".localized)") }
        if let fuel     = fuelType { components.append(fuel.displayString) }
        if let gear     = gearsType { components.append(gear.displayString) }
        return components.joined(separator: " ")
    }
    
    var coordinates: CLLocationCoordinate2D {
        guard let lat = latitude, let long = longitude else {
            return kCLLocationCoordinate2DInvalid
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var carName: String {
        var nameComponents = [String]()
        if let brand = brand { nameComponents.append(brand.cleanString) }
        if let model = model { nameComponents.append(model.cleanString) }
        return nameComponents.joined(separator: " ")
    }
    
    var carMainElementsString: String {
        var components = [String]()
        if let cat   = category { components.append(cat.displayString) }
        if let count = doorsCount { components.append("\(count) \("portes".localized)") }
        if let count = placesCount { components.append("\(count) \("sièges".localized)") }
        if let fuel  = fuelType { components.append(fuel.displayString) }
        if let gear  = gearsType { components.append(gear.displayString) }
        return components.joined(separator: " | ")
    }
}
