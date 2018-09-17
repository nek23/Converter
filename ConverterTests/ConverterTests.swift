//
//  ConverterTests.swift
//  ConverterTests
//
//  Created by Alex on 14.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import XCTest
@testable import Converter

class ConverterTests: XCTestCase {
  
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDate() {
        let unitDate = Date(timeIntervalSince1970: 0)
        let las = unitDate.subtract(days: 1).getDates(forLastNDays: 0)
        XCTAssertEqual(las, ["31/12/1969"])
    }
    
    func testTableHas15LastDays() {
        let controller = DatesTableController(with: DatesTablePresenter())
        let array = controller.presenter.model.dates
        XCTAssertEqual(array, Date().getDates(forLastNDays: 15))
        
    }
    
    func testControllerHasTableView() {
        let controller = DatesTableController(with: DatesTablePresenter())
        controller.loadViewIfNeeded()
        XCTAssertNotNil(controller.tableView)
    }
}
