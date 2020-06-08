//
//  D_TransformUITests.swift
//  D-TransformUITests
//
//  Created by Rohit on 5/19/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import XCTest

class D_TransformUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
    }
    
    func testEmployeeNameSaveValidations(){
        app.navigationBars["Employee List"].buttons["Add"].tap()
        let employeeNameErrorLabel = app.staticTexts["employeeNameErrorLabel"]
        app.navigationBars["Add Employee"].buttons["Save"].tap()
        XCTAssertEqual(employeeNameErrorLabel.label, "Invalid Employee name, Please provide value for text field.")
        app.textFields["Employee Name"].tap()
        app.textFields["Employee Name"].typeText("Rohit ^%&%")
        app.navigationBars["Add Employee"].buttons["Save"].tap()
        XCTAssertEqual(employeeNameErrorLabel.label, "Invalid Employee name, Employee name should not contain any special characters")
        app.textFields["Employee Name"].tap()
        app.textFields["Employee Name"].clearAndEnterText(text: "Rohit Shivankar")
        app.navigationBars["Add Employee"].buttons["Save"].tap()
        XCTAssertFalse(employeeNameErrorLabel.exists)
    }
    
    func testEmployeeNumberSaveValidations(){
        app.navigationBars["Employee List"].buttons["Add"].tap()
        let employeeNumberErrorLabel = app.staticTexts["employeeNumberErrorLabel"]
        app.navigationBars["Add Employee"].buttons["Save"].tap()
        XCTAssertEqual(employeeNumberErrorLabel.label, "Invalid Employee number, Please provide value for text field.")
        app.textFields["Employee Number"].tap()
        app.textFields["Employee Number"].typeText("332ABC24234")
        app.navigationBars["Add Employee"].buttons["Save"].tap()
        XCTAssertEqual(employeeNumberErrorLabel.label, "Invalid Employee number, Employee number should have less than 8 digits")
        app.textFields["Employee Number"].tap()
        app.textFields["Employee Number"].clearAndEnterText(text: "332ABC")
        app.navigationBars["Add Employee"].buttons["Save"].tap()
        XCTAssertEqual(employeeNumberErrorLabel.label, "Invalid Employee number, Employee number should only contains digits")
        app.textFields["Employee Number"].tap()
        app.textFields["Employee Number"].clearAndEnterText(text: "332862")
        app.navigationBars["Add Employee"].buttons["Save"].tap()
        XCTAssertFalse(employeeNumberErrorLabel.exists)
    }
}

extension XCUIElement {
    
    ///Removes any current text in the field before typing in the new value
    ///- Parameter text: the text to enter into the field
    ///
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
        self.typeText(text)
    }
}
