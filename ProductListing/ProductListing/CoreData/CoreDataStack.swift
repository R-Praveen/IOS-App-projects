//
//  CoreDataStack.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 20/02/23.
//

import Foundation
import CoreData

class CoreDataStack{
//    static let modelName = "Items"
//    private static var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: modelName)
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Unable to load persistent stores: \(error)")
//            }
//        }
//        return container
//    }()
//    var context: NSManagedObjectContext {
//        return Self.persistentContainer.viewContext
//    }
    
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Items")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        
        mainContext = persistentContainer.viewContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = self.mainContext
    }
}

