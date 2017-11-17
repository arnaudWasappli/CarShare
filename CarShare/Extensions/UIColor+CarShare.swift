//
//  UIColor+CarShare.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-14.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit

public extension UIColor {
    
    public convenience init(hexaString: String) {
        let hexString: String = hexaString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner           = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        self.init(r: r, g: g, b: b)
    }
    
    public convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public class var csVioletColor: UIColor {
        return UIColor(hexaString: "A94EE3")
    }
    
    public class var csTurquoiseColor: UIColor {
        return UIColor(hexaString: "2DE6C8")
    }
    
    public class var csDarkColor: UIColor {
        return UIColor(hexaString: "0F1E3C")
    }
    
    class var randomColor: UIColor {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
