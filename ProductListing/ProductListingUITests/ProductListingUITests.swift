//
//  ProductListingUITests.swift
//  ProductListingUITests
//
//  Created by Praveen Ramalingam on 27/02/23.
//

import XCTest

class ProductListingUITests: XCTestCase {
    
    func testSearchProductLists(){
        let app = XCUIApplication()
        app.launch()
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Same")
        let sameDayShipping = app.staticTexts["Same day shipping"]
        XCTAssertTrue(sameDayShipping.exists)
    }
    
    func testCheckStaticUITexts(){
        let app = XCUIApplication()
        app.launch()
        let explore = app.staticTexts["Explore"]
        XCTAssertTrue(explore.exists)
        let filter = app.staticTexts["Filter"]
        XCTAssertTrue(filter.exists)
        
    }
}
