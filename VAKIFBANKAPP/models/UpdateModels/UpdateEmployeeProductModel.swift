
import Foundation

struct UpdateEmployeeProductCheck: Codable {
    let updatedRecordId: Int
    let updatedProductId: Int
    let updatedNewProductId: Int
}

struct UpdateEmployeeProduct: Codable {
    let employeeProduct: UpdateEmployeeProductProperties
    let errorModel: UpdateEmployeeProductError
}

struct UpdateEmployeeProductProperties: Codable {
    let guidID: String
    let pairID, recordID, productID: Int

    enum CodingKeys: String, CodingKey {
        case guidID = "guidId"
        case pairID = "pairId"
        case recordID = "recordId"
        case productID = "productId"
    }
}

struct UpdateEmployeeProductError: Codable {
    let code, errorModelDescription: String

    enum CodingKeys: String, CodingKey {
        case code
        case errorModelDescription = "description"
    }
}


