//
//  CSMapCarViewController.swift
//  CarShare
//
//  Created by Arnaud on 17-11-15.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit
import MapKit

class CSMapCarViewController: UIViewController {
    
    public var data: [CSVehicle]? = nil
    
    private let mapView = MKMapView()
    
    override func loadView() {
        super.loadView()
        
        let latitude = 0.1
        var region = MKCoordinateRegion.parisRegion
        region.span = MKCoordinateSpan(latitudeDelta: latitude, longitudeDelta: latitude)
        mapView.region            = region
        mapView.delegate          = self
        mapView.showsUserLocation = true
        mapView.showsScale        = true
        mapView.showsCompass      = true
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerAnnotationViewClasses()
    }
    
    public func reload(with data: [CSVehicle]?) {
        self.data = data
        
        mapView.removeAnnotations(mapView.annotations)

        guard let data = data else {
            return
        }
        
        for veh in data {
            mapView.addAnnotation(CSVehicleAnnotation(vehicle: veh))
        }
    }
    
    func registerAnnotationViewClasses() {
        mapView.register(CSVehicleMapPinView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(CSVehicleClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
}

//MARK: MKMapViewDelegate
extension CSMapCarViewController: MKMapViewDelegate {
    
    //Fix crash from Apple: https://forums.developer.apple.com/thread/89427
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let marker = annotation as? CSVehicleAnnotation {
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? CSVehicleMapPinView
            if view == nil {
                //Very IMPORTANT
                view = CSVehicleMapPinView(annotation: marker, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            }
            return view
        } else if let cluster = annotation as? MKClusterAnnotation {
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier) as? CSVehicleClusterView
            if view == nil {
                //Very IMPORTANT
                view = CSVehicleClusterView(annotation: cluster, reuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
            }
            return view
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let pinView = view as? CSVehicleMapPinView, let annotation = pinView.annotation as? CSVehicleAnnotation {
            print("pin: \(annotation.vehicle)")
            //TODO: show detail of vehicle
        } else if let clusterView = view as? CSVehicleClusterView {
            print("cluster")
            //TODO: zoom in
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        //TODO: ask to reload content
    }
}
