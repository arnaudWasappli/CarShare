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
    
    let listViewController = CSListCarViewController()
    let mapViewController = CSMapCarViewController()
    let filterViewController = CSFilterViewController()
    
    override func loadView() {
        super.loadView()
        
        addChildViewController(listViewController)
        view.addSubview(listViewController.view)
        listViewController.didMove(toParentViewController: self)
        
        listViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mapViewController.view.isHidden = true
        addChildViewController(mapViewController)
        view.addSubview(mapViewController.view)
        mapViewController.didMove(toParentViewController: self)
        
        mapViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        filterViewController.pullUpControllerDelegate = self
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
        
        title = "CarShare".localized
        
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
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        let duration: TimeInterval = 0.4
        let firstView: UIView = sender?.selectedSegmentIndex == 0 ? mapViewController.view : listViewController.view
        let secondView: UIView = sender?.selectedSegmentIndex == 0 ? listViewController.view : mapViewController.view
        
        UIView.transition(with: firstView, duration: duration, options: transitionOptions, animations: {
            firstView.isHidden = true
        })
        UIView.transition(with: secondView, duration: duration, options: transitionOptions, animations: {
            secondView.isHidden = false
        })
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
                    if ($0.doorsCount ?? 0) < 5 {
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
        
        listViewController.reload(with: filteredData)
        mapViewController.reload(with: filteredData)
    }
}

extension CSMainViewController: PullUpControllerDelegate {
    
    func pullUpControllerDidScroll(_ pullUpController: PullUpController) {
        listViewController.minimumOffset = pullUpController.currentTopOffset ?? listViewController.minimumOffset
    }
}
