//
//  ViewModel.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 15/02/23.
//

import Foundation

class ViewModel{
    var networkService: NetworkService
    var coreDataHelper: CoreDataHelper
    
    //Initializing the network service and coredataHelper
    init(){
        networkService = NetworkService()
        coreDataHelper = CoreDataHelper(coreDataStack: CoreDataStack())
    }
    
    /*This method fetches the value from the API and stores in the Core data
     And returns the value using a callback
     */
    func getItems( callback: @escaping ([StoreItem]) -> ()){
        var apiData: Response?
        networkService.getData(callback: {response in
            var storeItems: [StoreItem] = []
            apiData = response
            if(apiData?.data.items != nil){
                storeItems = self.coreDataHelper.saveStoreItems(items: apiData!.data.items)
                callback(storeItems)
            }
            else{
                self.coreDataHelper.fetchItemsFromCoreData(saveItems: {storeItems in
                    callback(storeItems)
                })
            }
        })
       
    }
}


