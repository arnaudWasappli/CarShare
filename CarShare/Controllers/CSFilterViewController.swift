//
//  CSFilterViewController.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-16.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit
import PullUpController

class CSFilterViewController: PullUpController {
    
    private var visualEffectView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    private var searchButton       : UIButton     = UIButton(type: .system)
    private var categoryLabel      : UILabel      = UILabel()
    private var categoryScrollView : UIScrollView = UIScrollView()
    private var featureLabel       : UILabel      = UILabel()
    
    //I should create a tableView with all this filters but don't have time
    private var automaticLabel  : UILabel  = UILabel()
    private var automaticSwitch : UISwitch = UISwitch()
    private var fiveDoorsLabel  : UILabel  = UILabel()
    private var fiveDoorsSwitch : UISwitch = UISwitch()
    private var electricLabel   : UILabel  = UILabel()
    private var electricSwitch  : UISwitch = UISwitch()
    
    override func loadView() {
        super.loadView()
        
        view.layer.shadowRadius  = 5
        view.layer.shadowColor   = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        
        visualEffectView.layer.cornerRadius = 12
        visualEffectView.clipsToBounds      = true
        view.addSubview(visualEffectView)
        
        visualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let sepHeight: CGFloat = 6.0
        let separator = UIView()
        separator.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        separator.layer.cornerRadius = sepHeight / 2
        view.addSubview(separator)
        
        separator.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(sepHeight)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(sepHeight)
        }
        
        searchButton.setImage(#imageLiteral(resourceName: "filter_icon"), for: .normal)
        searchButton.setTitle("Filtres".localized, for: .normal)
        searchButton.titleLabel?.font  = UIFont.systemFont(ofSize: 18.0)
        searchButton.tintColor         = UIColor.black
        searchButton.imageEdgeInsets   = UIEdgeInsetsMake(0, 0, 0, 10)
        searchButton.titleEdgeInsets   = UIEdgeInsetsMake(0, 10, 0, 0)
        searchButton.addTarget(self, action: #selector(pullUpPanel(_:)), for: .touchUpInside)
        view.addSubview(searchButton)
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(Constants.topButtonHeight)
        }
        
        featureLabel.text      = "Caractéristiques".localized
        featureLabel.textColor = .black
        featureLabel.font      = UIFont.boldSystemFont(ofSize : 22)
        view.addSubview(featureLabel)
        
        featureLabel.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        automaticLabel.text      = "Boite automatique".localized
        automaticLabel.textColor = .darkText
        automaticLabel.font      = UIFont.systemFont(ofSize: 18)
        view.addSubview(automaticLabel)
        
        automaticLabel.snp.makeConstraints { make in
            make.top.equalTo(featureLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        automaticSwitch.tag         = CSFilter.automatic.hashValue
        automaticSwitch.onTintColor = UIColor.csTurquoiseColor
        automaticSwitch.isOn        = CSFilterManager.shared.filter(.automatic) as! Bool
        automaticSwitch.addTarget(self, action: #selector(switchChangedValue(_:)), for: .valueChanged)
        view.addSubview(automaticSwitch)
        
        automaticSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(automaticLabel)
            make.leading.greaterThanOrEqualTo(automaticLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        fiveDoorsLabel.text      = "5 portes et +".localized
        fiveDoorsLabel.textColor = .darkText
        fiveDoorsLabel.font      = UIFont.systemFont(ofSize: 18)
        view.addSubview(fiveDoorsLabel)
        
        fiveDoorsLabel.snp.makeConstraints { make in
            make.top.equalTo(automaticLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
        }
        
        fiveDoorsSwitch.tag         = CSFilter.moreThan5Doors.hashValue
        fiveDoorsSwitch.onTintColor = UIColor.csTurquoiseColor
        fiveDoorsSwitch.isOn        = CSFilterManager.shared.filter(.moreThan5Doors) as! Bool
        fiveDoorsSwitch.addTarget(self, action: #selector(switchChangedValue(_:)), for: .valueChanged)
        view.addSubview(fiveDoorsSwitch)
        
        fiveDoorsSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(fiveDoorsLabel)
            make.leading.greaterThanOrEqualTo(fiveDoorsLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        electricLabel.text      = "Électrique".localized
        electricLabel.textColor = .darkText
        electricLabel.font      = UIFont.systemFont(ofSize: 18)
        view.addSubview(electricLabel)
        
        electricLabel.snp.makeConstraints { make in
            make.top.equalTo(fiveDoorsLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
        }
        
        electricSwitch.tag         = CSFilter.electric.hashValue
        electricSwitch.onTintColor = UIColor.csTurquoiseColor
        electricSwitch.isOn        = CSFilterManager.shared.filter(.electric) as! Bool
        electricSwitch.addTarget(self, action: #selector(switchChangedValue(_:)), for: .valueChanged)
        view.addSubview(electricSwitch)
        
        electricSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(electricLabel)
            make.leading.greaterThanOrEqualTo(electricLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        categoryLabel.text      = "Catégories".localized
        categoryLabel.textColor = .black
        categoryLabel.font      = UIFont.boldSystemFont(ofSize : 22)
        view.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(electricLabel.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        categoryScrollView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        view.addSubview(categoryScrollView)
        
        categoryScrollView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(120.0)
        }
        
        let label = UILabel()
        label.text = "Categories in progress".localized
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalTo(categoryScrollView)
        }
    }
    
    @objc func pullUpPanel(_ sender: Any?) {
        pullUpControllerMoveToVisiblePoint(currentTopOffset == minimumOffset ? Constants.maxPanelHeight : minimumOffset) {
            
        }
    }
    
    @objc func switchChangedValue(_ sw: UISwitch) {
        let tag = sw.tag
        guard let filter = CSFilter(rawValue: tag) else {
            return
        }
        CSFilterManager.shared.set(value: sw.isOn, for: filter)
    }
    
    var minimumOffset: CGFloat {
        return Constants.topButtonHeight + max(view.safeAreaInsets.bottom, (navigationController?.view.safeAreaInsets.bottom ?? 0.0))
    }
    
    // MARK: - PullUpController
    override var pullUpControllerPreferredSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: Constants.maxPanelHeight)
    }
    
    override var pullUpControllerPreviewOffset: CGFloat {
        return minimumOffset
    }
    
    override var pullUpControllerIsBouncingEnabled: Bool {
        return false
    }
    
    override func pullUpControllerOffsetIsChanging() {
        super.pullUpControllerOffsetIsChanging()
    }
}

extension CSFilterViewController {
    
    struct Constants {
        static let topButtonHeight: CGFloat = 46.0
        static let maxPanelHeight:  CGFloat = 450.0
    }
}
