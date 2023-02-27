//
//  StoreItem+CoreDataProperties.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 27/02/23.
//
//

import Foundation
import CoreData


extension StoreItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoreItem> {
        return NSFetchRequest<StoreItem>(entityName: "StoreItem")
    }

    @NSManaged public var extra: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?

}

extension StoreItem : Identifiable {

}
