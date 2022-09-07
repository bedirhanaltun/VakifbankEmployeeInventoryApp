import Foundation

struct DeleteProductCheck: Codable{
    let id: Int
}

struct DeleteProduct: Codable {
    let product: DeleteProductProperties
    let errorModel: DeleteProductError
}

struct DeleteProductError: Codable {
    let code, errorModelDescription: String

    enum CodingKeys: String, CodingKey {
        case code
        case errorModelDescription = "description"
    }
}

struct DeleteProductProperties: Codable {
    let guidID: String
    let productID: Int
    let productName: String

    enum CodingKeys: String, CodingKey {
        case guidID = "guidId"
        case productID = "productId"
        case productName
    }
}
