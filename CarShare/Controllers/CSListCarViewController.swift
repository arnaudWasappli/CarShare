//
//  CSListCarViewController.swift
//  CarShare
//
//  Created by Arnaud Lays on 17-11-15.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class CSListCarViewController: UIViewController {
    
    lazy private var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing      = 10
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor      = .white
        collectionView.dataSource           = self.dataManager
        collectionView.delegate             = self.dataManager
        collectionView.emptyDataSetSource   = self
        collectionView.emptyDataSetDelegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib(nibName: "CSVehicleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CSVehicleCollectionViewCell")
        return collectionView
    }()
    
    public var dataManager = CSVehicleDataManager()
    
    var minimumOffset: CGFloat = 0 {
        didSet {
            collectionView.contentInset = UIEdgeInsetsMake(0, 0, minimumOffset, 0)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        collectionView.backgroundColor = UIColor(hexaString: "EEEEEE")
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func reload(with data: [CSVehicle]?) {
        dataManager.data = data
        collectionView.reloadData()
        
        if data?.count == 0 {
            //TODO: issue with EmptyDataSet. It never shows when scrollView is not on top. Need investigation!
            collectionView.scrollRectToVisible(CGRect.zero, animated: false)
            collectionView.reloadEmptyDataSet()
        }
    }
}

extension CSListCarViewController: DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString {
        return NSAttributedString(string: "Aucun vehicle disponible".localized)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return #imageLiteral(resourceName: "car_key")
    }
    
    func imageTintColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return UIColor.csTurquoiseColor
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -60
    }
}

extension CSListCarViewController: DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}
