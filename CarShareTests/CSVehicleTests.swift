//
//  CSVehicleTests.swift
//  CarShareTests
//
//  Created by Arnaud Lays on 17-11-16.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import XCTest

class CSVehicleTests: XCTestCase {
    
    /* TestVehicleNissanMicra.json
     {
         "address_id": 70076,
         "id": 10749,
         "year": 2012,
         "doors_count": 5,
         "places_count": 5,
         "fuel_type_cd": 0,
         "gears_type_cd": 1,
         "vehicle_model": "Micra",
         "brand": "Nissan",
         "category": "CITADINE",
         "thumbnail_url": "https://koolicar.s3.amazonaws.com/uploads/photo/6103/thumb_2015-11-09_16.13.02.jpg",
         "distance_string": "Paris 11'e8me",
         "fake_latitude": 48.8619248152841,
         "fake_longitude": 2.38026285387939
     }
     */
    
    func testFileReadable() -> Data? {
        do {
            if let data = try CSService.shared.readJSONFile(of: "TestVehicleNissanMicra") {
                XCTAssert(true)
                return data
            } else {
                XCTAssert(false, "Data should exist")
            }
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }
        return nil
    }
    
    func testJSONFileToVehicle() -> CSVehicle? {
        let data = self.testFileReadable()!
        let decoder = JSONDecoder()
        do {
            let vehicle = try decoder.decode(CSVehicle.self, from: data)
            return vehicle as CSVehicle
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }
        return nil
    }
    
    func testVehicleCodable() {
        let vehicle = self.testJSONFileToVehicle()
        XCTAssertEqual(vehicle?.carName, "Nissan Micra")
        XCTAssertEqual(vehicle?.doorsCount, 5)
        XCTAssertEqual(vehicle?.placesCount, 5)
        XCTAssertEqual(vehicle?.fuelType, CSFuelType.gaz)
        XCTAssertEqual(vehicle?.gearsType, CSGearType.manual)
        XCTAssertEqual(vehicle?.category, CSCategory.city)
        XCTAssertEqual(vehicle?.distance, "Paris 11ème")
        XCTAssertEqual(vehicle?.latitude, 48.8619248152841)
        XCTAssertEqual(vehicle?.longitude, 2.38026285387939)
        XCTAssertEqual(vehicle?.thumbnail, "https://koolicar.s3.amazonaws.com/uploads/photo/6103/thumb_2015-11-09_16.13.02.jpg")
    }
}
