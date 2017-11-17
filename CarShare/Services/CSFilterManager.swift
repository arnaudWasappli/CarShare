//
//  CSFilterManager.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-16.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit

enum CSFilter: Int {
    case exists, automatic, moreThan5Doors, electric
    
    var key: String {
        return "filter_key_\(self)"
    }
}

class CSFilterManager: NSObject {

    static let notificationFiltersChanged = NSNotification.Name(rawValue: "notificationFiltersChanged")
    
    static let shared = CSFilterManager()
    
    private override init() {
        super.init()
        if (self.filter(.exists) as! Bool) == false {
            self.set(value: true, for: .exists)
            self.set(value: false, for: .automatic)
            self.set(value: false, for: .moreThan5Doors)
            self.set(value: false, for: .electric)
        }
    }
    func filter(_ filter: CSFilter) -> Any {
        if [.exists, .automatic, .moreThan5Doors, .electric].contains(filter) {
            return UserDefaults.standard.bool(forKey: filter.key)
        }
        return UserDefaults.standard.object(forKey: filter.key) ?? ""
    }
    
    func set(value: Any, for filter: CSFilter) {
        UserDefaults.standard.setValue(value, forKey: filter.key)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: CSFilterManager.notificationFiltersChanged, object: nil)
    }
}
