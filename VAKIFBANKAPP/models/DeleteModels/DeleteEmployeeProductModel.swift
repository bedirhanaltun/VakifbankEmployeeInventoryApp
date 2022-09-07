
import Foundation

struct DeleteEmployeeProductCheck: Codable{
    let id: Int
}

struct DeleteEmployeeProduct: Codable {
    let employeeProduct: DeleteEmployeeProductProperties
    let errorModel: DeleteEmployeeProductError
}

struct DeleteEmployeeProductProperties: Codable {
    let guidID: String
    let pairID, recordID, productID: Int

    enum CodingKeys: String, CodingKey {
        case guidID = "guidId"
        case pairID = "pairId"
        case recordID = "recordId"
        case productID = "productId"
    }
}

struct DeleteEmployeeProductError: Codable {
    let code, errorModelDescription: String

    enum CodingKeys: String, CodingKey {
        case code
        case errorModelDescription = "description"
    }
}
