//
//  CSService.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-14.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit

public typealias CSVehicleCompletion = (CSVehicle?, Error?) -> Void
public typealias CSVehiclesCompletion = ([CSVehicle]?, Error?) -> Void

class CSService: NSObject {
    
    static let shared = CSService()
    
    func readTestFileJsonOfAllVehicules(_ completion: @escaping CSVehiclesCompletion) {
        do {
            if let data = try readJSONFile(of: "TestTechniqueKoolicariOS") {
                let decoder = JSONDecoder()
                let vehicleList = try decoder.decode(CSVehicleList.self, from: data)
                completion(vehicleList.vehicles, nil)
            }
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }
    }
    
    func readJSONFile(of name: String) throws -> Data? {
        if let path = Bundle(for: type(of: self)).path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch let error {
                print(error.localizedDescription)
                throw error
            }
        } else {
            print("Invalid filename/path.")
            let error = NSError(domain: "Invalid filename/path", code: 0, userInfo: nil)
            throw error
        }
    }
}
