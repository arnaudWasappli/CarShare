//
//  CSNavigationViewController.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-14.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit

class CSNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationBar.tintColor           = .white
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationBar.barTintColor        = UIColor.csDarkColor
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
