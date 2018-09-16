//
//  ConverterTests.swift
//  ConverterTests
//
//  Created by Alex on 14.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import XCTest
@testable import Converter
import Quick

class ConverterTests: XCTestCase {
 
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testData() {
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
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
