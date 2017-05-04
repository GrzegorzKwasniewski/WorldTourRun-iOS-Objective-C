//
//  WorldTourRunUITests.swift
//  WorldTourRunUITests
//
//  Created by Grzegorz on 03/05/2017.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

import XCTest

class ViewControllersNavigationUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        XCUIApplication().launch()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Navigation_MainVC_To_NewRunVC() {
        
        let app = XCUIApplication()
        let newRunVCButton = app.buttons["New Run"]
        
        XCTAssertEqual(newRunVCButton.value as! String, "")
        
        newRunVCButton.tap()
        
        XCTAssertEqual(newRunVCButton.exists, false)

        let backButton = app.navigationBars["New Run"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0)
        
        XCTAssertEqual(backButton.value as! String, "")
        
        backButton.tap()
        
        XCTAssertEqual(backButton.exists, false)
        
    }
    
    func test_Navigation_MainVC_To_FinishedRunsVC() {
        
        let app = XCUIApplication()
        let finishedRunsVCButton = app.buttons["Finished Runs"]
        
        XCTAssertEqual(finishedRunsVCButton.value as! String, "")
        
        finishedRunsVCButton.tap()
        
        XCTAssertEqual(finishedRunsVCButton.exists, false)
        
        let backButton = app.navigationBars["Finished Runs"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0)
        
        XCTAssertEqual(backButton.value as! String, "")
        
        backButton.tap()
        
        XCTAssertEqual(backButton.exists, false)
        
    }
    
    func test_Navigation_MainVC_To_TrophiesVC() {
        
        let app = XCUIApplication()
        let trophiesVCButton = app.buttons["Trophies"]
        
        XCTAssertEqual(trophiesVCButton.value as! String, "")
        
        trophiesVCButton.tap()
        
        XCTAssertEqual(trophiesVCButton.exists, false)
        
        let backButton = app.navigationBars["Trophies"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0)
        
        XCTAssertEqual(backButton.value as! String, "")
        
        backButton.tap()
        
        XCTAssertEqual(backButton.exists, false)
        
    }
    
}
