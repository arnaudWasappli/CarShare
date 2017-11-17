//
//  String+CarShare.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-14.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit

extension String {
    
    var localized: String {
        return self.localized(nil)
    }
    
    func localized(_ comment: String?) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
    
    var cleanString: String {
        return self.replacingOccurrences(of: "'e8", with: "è").replacingOccurrences(of: "'e9", with: "é")
    }
}
