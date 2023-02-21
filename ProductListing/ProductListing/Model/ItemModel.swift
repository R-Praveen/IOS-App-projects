//
//  ItemModel.swift
//  ProductListing
//
//  Created by Praveen Ramalingam on 20/02/23.
//

import Foundation

struct Item: Codable{
    let name: String
    let price: String
    let extra: String?
    let image: String?
}
