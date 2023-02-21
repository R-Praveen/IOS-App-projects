//
//  CoreDataTestStack.swift
//  ProductListingTests
//
//  Created by Praveen Ramalingam on 20/02/23.
//

import CoreData

class CoreDataTestStack: CoreDataStack{
    
    func setupCoreDataHelper(){
        let persistentContainerStoreDescription = NSPersistentStoreDescription()
        persistentContainerStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: "Items")
        container.persistentStoreDescriptions = [persistentContainerStoreDescription]
    }
}
