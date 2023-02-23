//
//  CoreDataStack.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 20/02/23.
//

import Foundation
import CoreData
class CoreDataStack{
    static let modelName = "Items"
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    var context: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }
}

