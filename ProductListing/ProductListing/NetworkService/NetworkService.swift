//
//  NetworkService.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 15/02/23.
//

import Foundation

class NetworkService{
    
    //This method fetches the value from the API and decodes and returns the value
    func getData( callback: @escaping (Response) -> ()){
        print("in get data")
        let task = URLSession.shared.dataTask(with: URL(string: URLs.apiURL)!, completionHandler: {
            data, urlResponse,error in
            print("urlresponse")
            if error != nil {
                return
            }
            
            if let safeData = data{
                do{
                    let json = try JSONDecoder().decode(Response.self, from: safeData)
                    callback(json)
                }
                catch{
                    print(error)
                }
            }
        })
        task.resume()
    }
}


