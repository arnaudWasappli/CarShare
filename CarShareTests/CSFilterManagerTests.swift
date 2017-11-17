//
//  CSFilterManagerTests.swift
//  CarShareTests
//
//  Created by Arnaud Lays on 17-11-16.
//  Copyright © 2017 Arnaud Lays. All rights reserved.
//

import XCTest

class CSFilterManagerTests: XCTestCase {
    
    func testFilterValue() {
        let filterManager = CSFilterManager.shared
        let valueAutomatic = filterManager.filter(.automatic)
        let valueMoreThan5Doors = filterManager.filter(.moreThan5Doors)
        let valueElectric = filterManager.filter(.electric)
        XCTAssert(valueAutomatic is Bool)
        XCTAssert(valueMoreThan5Doors is Bool)
        XCTAssert(valueElectric is Bool)
    }
}
