//
//  CoreDataStack.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 20/02/23.
//

import Foundation
import CoreData
class CoreDataStack{
    let modelName = "Items"
    var persistenceContainer: NSPersistentContainer
    var mainContext: NSManagedObjectContext
    init(){
        persistenceContainer = NSPersistentContainer(name: modelName)
        persistenceContainer.loadPersistentStores{ _,error in
            if let error = error as NSError?{
                fatalError("Unresolved error")
            }
        }
        mainContext = persistenceContainer.viewContext
    }
//    static let model: NSManagedObjectModel = {
//        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
//        return NSManagedObjectModel(contentsOf: modelURL)!
//    }()
    
//    var storeContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: modelName)
//        container.loadPersistentStores{ _,error in
//            if let error = error as NSError?{
//                fatalError("Unresolved error")
//            }
//        }
//        return container
//    }()
    
//    private func saveContext () {
//       context.perfom {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
    func getMainContext() -> NSManagedObjectContext{
        persistenceContainer.viewContext
    }
    
}

