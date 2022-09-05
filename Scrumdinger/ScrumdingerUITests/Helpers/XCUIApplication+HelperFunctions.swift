//
//  XCUIApplication+HelperFunctions.swift
//  ScrumdingerUITests
//
//  Created by Erich Flock on 05.09.22.
//

import XCTest

extension XCUIApplication {
    
    func tapOnButton(_ identifier: String, timeout: Double = 60) {
        let button = buttons[identifier].firstMatch
        if button.waitForExistence(timeout: timeout) {
            button.tap()
        } else {
            XCTFail("Fail to tap on button \(identifier)")
        }
    }
    
    func textIsVisible(_ text: String, timeout: Double = 60) -> Bool {
        let staticText = staticTexts[text]
        return staticText.waitForExistence(timeout: timeout)
    }
    
    func type(text: String, on identifier: String, timeout: Double = 60) {
        let textField = textFields[identifier].firstMatch
        if textField.waitForExistence(timeout: timeout) {
            textField.tap()
            textField.clearAndEnterText(text: text)
        } else {
            XCTFail("Fail to type \(text) on text field \(identifier)")
        }
    }
    
}
