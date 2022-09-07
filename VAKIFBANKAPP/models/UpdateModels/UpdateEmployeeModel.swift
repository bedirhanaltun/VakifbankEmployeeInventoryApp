import Foundation

struct UpdateEmployee: Codable {
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
