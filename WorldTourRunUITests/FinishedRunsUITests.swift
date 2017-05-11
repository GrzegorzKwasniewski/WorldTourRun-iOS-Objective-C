//
//  FinishedRunsUITests.swift
//  WorldTourRun
//
//  Created by Grzegorz on 11/05/2017.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

import XCTest

class FinishedRunsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        XCUIApplication().launch()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_DeleteFinishedRun() {
        
        let app = XCUIApplication()
        app.buttons["Finished Runs"].tap()
        
        let cell = app.tables.cells.element(boundBy: 0)
        
        if cell.exists {
            cell.swipeLeft()
            cell.children(matching: .button).matching(identifier: "Delete").element(boundBy: 0).tap()

        }
    }
}
