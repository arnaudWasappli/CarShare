//
//  CSMainViewController.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-14.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit
import PullUpController

class CSMainViewController: UIViewController {
    
    var data: [CSVehicle]? = nil {
        didSet {
            refreshData()
        }
    }
    
    let filterViewController = CSFilterViewController()
    
    override func loadView() {
        super.loadView()
        
        addPullUpController(filterViewController)
    }
    
    private func addSwitchMapListButton() {
        let switchView = UISegmentedControl(items: [#imageLiteral(resourceName: "mode_list"), #imageLiteral(resourceName: "mode_map")])
        switchView.selectedSegmentIndex = 0
        switchView.setWidth(50, forSegmentAt: 0)
        switchView.setWidth(50, forSegmentAt: 1)
        switchView.tintColor = .white//UIColor.csTurquoiseColor
        switchView.addTarget(self, action: #selector(switchMapListTouched(_:)), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: switchView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CarShare"
        
        view.backgroundColor = .white
        
        addSwitchMapListButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: CSFilterManager.notificationFiltersChanged, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CSService.shared.readTestFileJsonOfAllVehicules({ [weak self] vehicles, error in
            guard let weakSelf = self else {
                return
            }
            weakSelf.data = vehicles
        })
    }
    
    @objc func switchMapListTouched(_ sender: UISegmentedControl?) {
        
    }
    
    @objc func refreshData() {
        var filteredData = data
        
        let onlyAutomaticVehicle        : Bool = CSFilterManager.shared.filter(.automatic) as! Bool
        let onlyFiveDoorsAndMoreVehicle : Bool = CSFilterManager.shared.filter(.moreThan5Doors) as! Bool
        let onlyElectricVehicle         : Bool = CSFilterManager.shared.filter(.electric) as! Bool
        
        //No need to apply this filter if none of the filters are selected
        if onlyAutomaticVehicle || onlyFiveDoorsAndMoreVehicle || onlyElectricVehicle {
            
            filteredData = filteredData?.filter({
                if onlyAutomaticVehicle {
                    if $0.gearsType != .automatic {
                        return false
                    }
                }
                if onlyFiveDoorsAndMoreVehicle {
                    if ($0.doorsCount ?? 0) < 10 {
                        return false
                    }
                }
                if onlyElectricVehicle {
                    if $0.fuelType != .electric {
                        return false
                    }
                }
                return true
            })
        }
    }
}
