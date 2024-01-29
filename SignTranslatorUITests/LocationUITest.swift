//
//  LocationUITest.swift
//  SignTranslatorUITests
//
//  Created by Thomas on 29/1/2024.
//

import XCTest

final class LocationUITest: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocationView() {
        // Arrange
        let app = XCUIApplication()
        let nameTextField = app.textFields["Name"]
        let latTextField = app.textFields["Lat"]
        let lngTextField = app.textFields["Lng"]
        let addButton = app.buttons["Add"]
        
        // Act
        nameTextField.tap()
        nameTextField.typeText("Test")
        latTextField.tap()
        latTextField.typeText("22.3")
        lngTextField.tap()
        lngTextField.typeText("114.2")
        addButton.tap()
        
        // Assert
        XCTAssertEqual(nameTextField.value as? String, "Test", "The name text field should have the value 'Test'")
        XCTAssertEqual(latTextField.value as? String, "22.3", "The lat text field should have the value '22.3'")
        XCTAssertEqual(lngTextField.value as? String, "114.2", "The lng text field should have the value '114.2'")
    }

}
