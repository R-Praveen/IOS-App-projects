//
//  CoreDataTest.swift
//  ProductListingTests
//
//  Created by Praveen Ramalingam on 20/02/23.
//

import XCTest
@testable import ProductListing

class CoreDataTest: XCTestCase {
    var coreDataHelper: CoreDataHelper!
        
    override func setUp() {
        super.setUp()
        coreDataHelper = CoreDataHelper(managedObjectContext: CoreDataTestStack().mainContext)
    }
    override func tearDown() {
        coreDataHelper = nil
    }
    
    //Testcase to check the items are being saved properly
    func testSaveItems(){
        let items = [
        Item(name: "Item 1", price: "100", extra: "Same day shipping", image: "image")
        ]
        let storeItems = coreDataHelper.saveStoreItems(items: items)
        
        XCTAssertEqual(items.count, storeItems.count)
    }
    
    //Method checks to delete the items and values are being deleted by fetching from local data
    func testDeleteItems(){
        let items = [
        Item(name: "Item 1", price: "100", extra: "Same day shipping", image: "image")
        ]
        _ = coreDataHelper.saveStoreItems(items: items)
        coreDataHelper.fetchItemsFromCoreData(saveItems: {
            storeItems in
            XCTAssertEqual(storeItems.count, 1)
        })
    }
    
}
