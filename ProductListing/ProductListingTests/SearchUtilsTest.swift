//
//  SearchUtilsTest.swift
//  ProductListingTests
//
//  Created by Praveen Ramalingam on 26/02/23.
//

import XCTest
@testable import ProductListing

class SearchUtilsTest: XCTestCase {
    var coreDataHelper: CoreDataHelper!
    var coreDataTestStack: CoreDataTestStack!
    var mockViewModel: MockViewModel!
    var searchUtils: SearchUtils!
    override func setUp() {
        super.setUp()
        coreDataTestStack = CoreDataTestStack()
        coreDataHelper = CoreDataHelper(managedObjectContext: self.coreDataTestStack.mainContext)
        mockViewModel = MockViewModel(coreDataHelper: coreDataHelper)
        searchUtils = SearchUtils(viewModel: mockViewModel)
    }
    
    func testSearchItems(){
        let items = [
        Item(name: "Item 1", price: "100", extra: "Same day shipping", image: "image")
        ]
        _ = coreDataHelper.saveStoreItems(items: items)
        let storeItems = searchUtils.searchItems(text: "te")
        XCTAssertEqual(items.count, storeItems.count)
    }
    
}


class MockViewModel: ViewModelProtocol{
    var coreDataHelper: CoreDataHelper

    init(coreDataHelper: CoreDataHelper) {
        self.coreDataHelper = coreDataHelper
    }
    
    func getItems(callback: @escaping ([StoreItem]) -> ()) {
        callback([])
    }
    
    func getItemsFromCoreData(callback: @escaping ([StoreItem]) -> ()) {
        coreDataHelper.fetchItemsFromCoreData(saveItems: {storeItems in
            callback(storeItems)
        })
    }
}
