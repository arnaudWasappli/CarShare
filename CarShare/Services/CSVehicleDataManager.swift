//
//  CSVehicleDataManager.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-16.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit

public class CSVehicleDataManager: NSObject {
    
    public var data: [CSVehicle]? = nil
    
    func vehicle(at indexPath: IndexPath) -> CSVehicle? {
        guard let vehicles = data, indexPath.row < vehicles.count, let vehicle = vehicles[indexPath.row] as CSVehicle? else {
            return nil
        }
        return vehicle
    }
    
    func configureCell(_ cell: CSVehicleCollectionViewCell, for indexPath: IndexPath) {
        cell.vehicle = vehicle(at: indexPath)
    }
}

extension CSVehicleDataManager: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CSVehicleCollectionViewCell", for: indexPath) as! CSVehicleCollectionViewCell
        self.configureCell(cell, for: indexPath)
        return cell
    }
}

extension CSVehicleDataManager: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 140)
    }
}

extension CSVehicleDataManager: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vehicle = vehicle(at: indexPath) else {
            return
        }
        print(vehicle.searchString)
    }
}
