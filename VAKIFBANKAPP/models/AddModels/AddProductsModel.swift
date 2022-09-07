import Foundation


struct AddProductCheck: Codable {
    let newProductId: Int
    let newProductName: String
}


struct AddProduct: Codable {
    let product: AddProductProperties
    let errorModel: AddProductError
}

struct AddProductError: Codable {
    let code, errorModelDescription: String

    enum CodingKeys: String, CodingKey {
        case code
        case errorModelDescription = "description"
    }
}

struct AddProductProperties: Codable {
    let guidID: String
    let productID: Int
    let productName: String

    enum CodingKeys: String, CodingKey {
        case guidID = "guidId"
        case productID = "productId"
        case productName
    }
}
