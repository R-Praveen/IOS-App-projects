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
        viewModel.getItemsFromCoreData(callback: {(items: [StoreItem]) in
            if text.isEmpty || text.count<3 {
                filteredItems = items
                return
            }
                
        items.forEach({storeItem in
                if storeItem.name?.contains(text) ?? false
                {
                    filteredItems.append(storeItem)
                }
            })
        })
        
        return filteredItems
    }
}
