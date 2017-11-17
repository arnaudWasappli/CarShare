//
//  CSVehicleClusterView.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-15.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import MapKit

class CSVehicleClusterView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .required
        collisionMode   = .circle
        centerOffset    = CGPoint(x: 0, y: -10) // Offset center point to animate better with marker annotations
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            if let cluster = newValue as? MKClusterAnnotation {
                let width: CGFloat = 34.0
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: width))
                let count = cluster.memberAnnotations.count
                let priorityValue = MKFeatureDisplayPriority.defaultHigh.rawValue + min(MKFeatureDisplayPriority.defaultLow.rawValue, Float(count))
                //displayPriority = MKFeatureDisplayPriority(rawValue: priorityValue)
                
                image = renderer.image { _ in
                    let half: CGFloat = width / 2.0
                    
                    // Fill full circle with turquoise color
                    UIColor(named: "violet")?.setFill()
                    UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: width, height: width)).fill()
                    
                    // Fill inner circle with white color
                    UIColor(named: "turquoise")!.setFill()
                    let offset: CGFloat = 1
                    UIBezierPath(ovalIn: CGRect(x: offset, y: offset, width: width - offset * 2, height: width - offset * 2)).fill()
                    
                    // Finally draw count text vertically and horizontally centered
                    let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
                                      NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)]
                    let text = "\(count)"
                    let size = text.size(withAttributes: attributes)
                    let rect = CGRect(x: half - size.width / 2, y: half - size.height / 2, width: size.width, height: size.height)
                    text.draw(in: rect, withAttributes: attributes)
                }
            }
        }
    }
}
