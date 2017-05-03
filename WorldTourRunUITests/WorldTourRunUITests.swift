//
//  WorldTourRunUITests.swift
//  WorldTourRunUITests
//
//  Created by Grzegorz on 03/05/2017.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

import XCTest

class WorldTourRunUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
}
