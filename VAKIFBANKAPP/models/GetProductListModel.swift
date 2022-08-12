//
//  GetProductListModel.swift
//  VAKIFBANKAPP
//
//  Created by St900512 on 11.08.2022.
//

import Foundation

struct InventoryResponse: Codable {
    let productList : [Product]?
}


struct Product: Codable {
    let guidId: String
    let productId: Int
    let productName: String
}
