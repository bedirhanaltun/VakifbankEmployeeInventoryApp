import Foundation


struct AddEmployeeProductCheck: Codable{
    let newRecordId: Int
    let newProductId: Int
}



struct AddEmployeeProduct: Codable {
    let employeeProduct: AddEmployeeProductProperties
    let errorModel: AddEmployeeProductError
}

struct AddEmployeeProductProperties: Codable {
    let guidID: String
    let pairID, recordID, productID: Int

    enum CodingKeys: String, CodingKey {
        case guidID = "guidId"
        case pairID = "pairId"
        case recordID = "recordId"
        case productID = "productId"
    }
}

struct AddEmployeeProductError: Codable {
    let code, errorModelDescription: String

    enum CodingKeys: String, CodingKey {
        case code
        case errorModelDescription = "description"
    }
}
