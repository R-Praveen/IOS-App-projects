//
//  ResponseModel.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 20/02/23.
//

import Foundation


struct Response: Codable{
    let status: String
    let error: String?
    let data : ResponseData
}

struct ResponseData: Codable{
    let items: [Item]
}
