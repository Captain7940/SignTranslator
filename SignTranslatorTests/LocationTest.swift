//
//  LocationTest.swift
//  SignTranslatorTests
//
//  Created by Thomas on 29/1/2024.
//

import XCTest
@testable import SignTranslator

final class LocationTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddAnnotation() {
         // Arrange
         let locationView = LocationView()
         let name = "Test"
         let lat = "22.3"
         let lng = "114.2"
         let expectedCount = locationView.pointOfInterest.count
         
         // Act
         locationView.nameStr = name
         locationView.latStr = lat
         locationView.lngStr = lng
         locationView.addAnnotation()
         
         // Assert
         XCTAssertEqual(locationView.pointOfInterest.count, expectedCount)
     }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
