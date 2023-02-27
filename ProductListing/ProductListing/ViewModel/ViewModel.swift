//
//  ViewModel.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 15/02/23.
//

import Foundation

protocol ViewModelProtocol{
    func getItems( callback: @escaping ([StoreItem]) -> ())
    func getItemsFromCoreData(callback: @escaping ([StoreItem]) -> ())
}

class ViewModel: ViewModelProtocol{
    var networkService: NetworkService
    var coreDataHelper: CoreDataHelper
    
    //Initializing the network service and coredataHelper
    init(networkService: NetworkService, coreDataHelper: CoreDataHelper){
        self.networkService = networkService
        self.coreDataHelper = coreDataHelper
    }
    
    /*This method fetches the value from the API and stores in the Core data
     And returns the value using a callback
     */
    func getItems( callback: @escaping ([StoreItem]) -> ()){
        var apiData: Response?
        networkService.getData(callback: {response in
            var storeItems: [StoreItem] = []
            apiData = response
            self.coreDataHelper.deleteAll()
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
    
    func getItemsFromCoreData(callback: @escaping ([StoreItem]) -> ()){
            self.coreDataHelper.fetchItemsFromCoreData(saveItems: {storeItems in
                callback(storeItems)
            })
    }
}


