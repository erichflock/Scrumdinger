//
//  ScrumdingerUITests.swift
//  ScrumdingerUITests
//
//  Created by Erich Flock on 05.09.22.
//

import XCTest
import AVFoundation

class ScrumdingerUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        addUIInterruptionMonitor(withDescription: "Handle Alert") { alert -> Bool in
            let allowButton = alert.buttons["Allow"]
            if allowButton.waitForExistence(timeout: 5) {
                allowButton.tap()
            }
            let okButton = alert.buttons["OK"]
            if okButton.waitForExistence(timeout: 5) {
                okButton.tap()
            }
            return true
        }
        
        app = XCUIApplication()
        app.resetAuthorizationStatus(for: .microphone)
        app.launchArguments.append("UITestMode")
        app.launch()
    }

    override func tearDownWithError() throws {}

    func test_addScrum() {
        addNewDaily()
    }
    
    func test_removeScrum() {
        addNewDaily()
        
        app.swipeLeft("New Daily")
        
        app.tapOnButton("Delete")
    }
    
    func test_startMeeting() {
        addNewDaily()
        
        app.tapOnText("New Daily")
        
        app.tapOnText("detailView_startMeetingLabel")
        
        XCTAssertTrue(app.textIsVisible("New Daily"), "Title 'New Daily' not found")
    }
    
}

//MARK: Helpers
extension ScrumdingerUITests {
    
    private func addNewDaily() {
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
