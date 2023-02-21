//
//  CoreDataTest.swift
//  ProductListingTests
//
//  Created by Praveen Ramalingam on 20/02/23.
//

import XCTest

class CoreDataTest: XCTestCase {
    var coreDataHelper: CoreDataHelper!
    
    var coreDataTestStack: CoreDataTestStack!
    
    override func setUp() {
        super.setUp()
        coreDataTestStack = CoreDataTestStack()
        coreDataTestStack.setupCoreDataHelper()
        coreDataHelper = CoreDataHelper(coreDataStack: coreDataTestStack)
    }
    override func tearDown() {
        coreDataTestStack = nil
        coreDataHelper = nil
    }
    func creatingItem() async {
      }
      
      func fetchingDataFromLocal() async {
          
//          let result = coreDataHelper.fetchItemsFromCoreData(saveItems:)()
          
          // Checking if data is saved
//          XCTAssertTrue(isSaved)
          
//          XCTAssertEqual(result?.items.count, 1)
      }
      
    
}
