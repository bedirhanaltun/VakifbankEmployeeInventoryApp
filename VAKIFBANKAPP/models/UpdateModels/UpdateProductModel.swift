import Foundation

struct UpdateProduct: Codable {
    let product: UpdateProductProperties
    let errorModel: ErrorUpdateProduct
}

struct ErrorUpdateProduct: Codable {
    let code, errorModelDescription: String

    enum CodingKeys: String, CodingKey {
        case code
        case errorModelDescription = "description"
    }
}

struct UpdateProductProperties: Codable {
    let guidID: String
    let productID: Int
    let productName: String

    enum CodingKeys: String, CodingKey {
        case guidID = "guidId"
        case productID = "productId"
        case productName
    }
}

struct UpdateProductCheck: Codable {
    let updatedProductId: Int
    let updatedProductName: String
}
