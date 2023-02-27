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
    init(managedObjectContext: NSManagedObjectContext){
        self.managedObjectContext = managedObjectContext
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
            if managedObjectContext.hasChanges {
                managedObjectContext.performAndWait({
                    do {
                        try managedObjectContext.save()
                    }
                    catch{
                        print(error)
                    }
                })
            }
        })
        
        return storeItems
    }
    
    func deleteAll(){
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "StoreItem")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            do {
                try managedObjectContext.execute(deleteRequest)
                try managedObjectContext.save()
            }
            catch {
                print ("There was an error")
            }
        
    }
}
