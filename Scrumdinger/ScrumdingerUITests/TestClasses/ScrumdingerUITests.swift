//
//  ScrumdingerUITests.swift
//  ScrumdingerUITests
//
//  Created by Erich Flock on 05.09.22.
//

import XCTest

class ScrumdingerUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments.append("UITestMode")
        app.launch()
    }

    override func tearDownWithError() throws {}

    func test_addScrum() {
        XCTAssertTrue(app.textIsVisible("Daily Scrums"), "Text 'Daily Scrums' not found")
        
        XCTAssertFalse(app.textIsVisible("New Daily", timeout: 5), "precondition")
        
        app.tapOnButton("New Scrum")
        
        app.type(text: "New Daily", on: "detailEditView_titleTextField")
        
        app.type(text: "Max", on: "detailEditView_newAttendeeTextField")
        
        app.tapOnButton("detailEditView_addAttendeeButton")
        
        app.tapOnButton("scrumsView_addButton")
        
        XCTAssertTrue(app.textIsVisible("New Daily"), "Text 'New Daily' not found")
    }
}
