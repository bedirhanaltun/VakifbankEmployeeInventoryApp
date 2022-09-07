// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ProductLists: Codable {
    let productList: [GetProduct]
    let errorModel: ErrorProduct
}

struct ProductCheck: Codable {
    let id: Int
}

// MARK: - ErrorModel
struct ErrorProduct: Codable {
    let code, errorModelDescription: String

    enum CodingKeys: String, CodingKey {
        case code
        case errorModelDescription = "description"
    }
}

// MARK: - ProductList
struct GetProduct: Codable {
    let guidID: String
    let productID: Int
    let productName: String

    enum CodingKeys: String, CodingKey {
        case guidID = "guidId"
        case productID = "productId"
        case productName
    }
}

