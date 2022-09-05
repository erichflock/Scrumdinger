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
    
    func tapOnText(_ identifier: String, timeout: Double = 60) {
        let text = staticTexts[identifier].firstMatch
        if text.waitForExistence(timeout: timeout) {
            text.tap()
        } else {
            XCTFail("Fail to tap on text \(identifier)")
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
    
    func swipeLeft(_ text: String) {
        let staticText = staticTexts[text]
        if staticText.waitForExistence(timeout: 60) {
            staticText.swipeLeft()
        } else {
            XCTFail("Fail to swipe left on \(text)")
        }
    }
    
}
