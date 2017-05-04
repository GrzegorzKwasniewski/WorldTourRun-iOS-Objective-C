//
//  NewRunUITests.swift
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 04/05/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

import XCTest

class NewRunUITests: XCTestCase {
    
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false

        XCUIApplication().launch()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_SavingNewRunAfterFinish() {
        
        let newRunButton = app.buttons["New Run"]
        newRunButton.tap()
        
        let startButton = app.buttons["Start"]
        
        XCTAssertEqual(startButton.isEnabled, true)
        XCTAssertEqual(startButton.isSelected, false)

        startButton.tap()
        
        let stopButton = app.buttons["Stop"]
        
        XCTAssertEqual(stopButton.isEnabled, true)
        
        stopButton.tap()
        
        XCTAssertEqual(stopButton.isSelected, false)
        
        let saveSheetButton = app.sheets.buttons["Save"]
        saveSheetButton.tap()
        
        XCTAssertEqual(saveSheetButton.exists, false)
        
    }
    
}
