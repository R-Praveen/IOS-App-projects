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
        XCUIApplication().windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .searchField).element.tap()
        
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
