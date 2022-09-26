import Foundation

struct UpdateEmployeeCheck: Codable {
    let updatedRecordID: Int
    let updatedEmployeeName, updatedEmployeeSurname, updatedEmployeeDepartment, updatedEmployeeEmail: String
    let updatedProductID, updatedNewProductID: Int

    enum CodingKeys: String, CodingKey {
        case updatedRecordID = "updatedRecordId"
        case updatedEmployeeName, updatedEmployeeSurname, updatedEmployeeDepartment, updatedEmployeeEmail
        case updatedProductID = "updatedProductId"
        case updatedNewProductID = "updatedNewProductId"
    }
}


struct UpdateEmployee: Codable {
    let employee: Employee
    let errorModel: UpdateEmployeeErrorModel
}


struct UpdateEmployeeErrorModel: Codable {
    let code, errorModelDescription: String

    enum CodingKeys: String, CodingKey {
        case code
        case errorModelDescription = "description"
    }
}
