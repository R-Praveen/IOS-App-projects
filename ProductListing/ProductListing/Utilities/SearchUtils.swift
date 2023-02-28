//
//  File.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 24/02/23.
//

import Foundation

class SearchUtils{
    private let viewModel: ViewModelProtocol!
    
    init(viewModel: ViewModelProtocol){
        self.viewModel = viewModel
    }
    
    func searchItems(text: String) -> [StoreItem]{
        var filteredItems: [StoreItem] = []
        viewModel.getItemsFromCoreData(callback: {items in
            if text.isEmpty || text.count<3 {
                filteredItems = items
                return
            }
                
            (items as NSArray).forEach({storeItem in
                if (storeItem as? StoreItem)?.name?.contains(text) ?? false
                {
                    filteredItems.append((storeItem as! StoreItem))
                }
                else if (storeItem as? StoreItem)?.extra?.contains(text) ?? false
                {
                    filteredItems.append((storeItem as! StoreItem))
                }
                else if (storeItem as? StoreItem)?.price?.contains(text) ?? false
                {
                    filteredItems.append((storeItem as! StoreItem))
                }
            })
        })
        
        return filteredItems
    }
}
