//
//  CoreDataHelpers.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 20/02/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper{
    private let managedObjectContext: NSManagedObjectContext
    private let coreDataStack: CoreDataStack
    init(coreDataStack: CoreDataStack){
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.getMainContext()
    }
    /*Fetches Item from Core data and if local data is empty
    value is fetched from API.
    And the value is stored in the local storage
     */
    func fetchItemsFromCoreData(saveItems: @escaping ([StoreItem]) -> ()){
            var storeItems: [StoreItem]?
            do{
                storeItems  = try managedObjectContext.fetch(StoreItem.fetchRequest())
            }
            catch{
                print(error)
            }
                saveItems(storeItems!)
        
    }
    
    //This method stores values in local storage.
    func saveStoreItems(items: [Item])-> [StoreItem]{
        var storeItems: [StoreItem] = []
        items.forEach({item in
            let storeItem = StoreItem(context: managedObjectContext)
            storeItem.price = item.price
            storeItem.name = item.name
            storeItem.image = item.image
            storeItem.extra = item.extra ?? ""
            storeItems.append(storeItem)
            do {
                try managedObjectContext.save()
            }
            catch{
                print(error)
            }
        })
        
        return storeItems
    }
}
