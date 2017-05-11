//
//  RunRemindersUITests.swift
//  WorldTourRun
//
//  Created by Grzegorz on 10/05/2017.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

import XCTest

class RunRemindersUITests: XCTestCase {
    
    var app = XCUIApplication()
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        XCUIApplication().launch()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_GrantPermissionToAccesReminders() {
        
        app.buttons["Run Reminders"].tap()
        
        let permissionAlert = app.alerts["“WorldTourRun” Would Like to Access Your Reminders"]
        
        if permissionAlert.exists {
            permissionAlert.buttons["OK"].tap()
        }
        
    }
    
    func test_DenyPermissionToAccesReminders() {
        
        app.buttons["Run Reminders"].tap()
        
        let permissionAlert = app.alerts["“WorldTourRun” Would Like to Access Your Reminders"]
        
        if permissionAlert.exists {
            permissionAlert.buttons["Don't Allow"].tap()
        }
        
    }
    
    func test_AddNewRunReminder() {
        
        app.buttons["Run Reminders"].tap()
        app.navigationBars["Run Reminders"].buttons["Add"].tap()
        
        let newRunEventAlert = app.alerts["New Run Event"]
        newRunEventAlert.collectionViews.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText("run")
        newRunEventAlert.buttons["Save"].tap()
        
        XCTAssertEqual(app.tables.cells.count, 1)
        
        app.tables.buttons["Reminde me"].tap()
        app.alerts["Reminder for Your Run was added!"].buttons["OK"].tap()
    
    }
}
