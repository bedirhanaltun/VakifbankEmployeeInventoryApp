import Foundation


struct AddEmployeeCheck: Codable {
    let newRecordId: Int
    let newEmployeeName: String
    let newEmployeeSurname: String
    let newEmployeeDepartment: String
    let newEmployeeEmail: String
    let newProductId: Int
}


struct AddEmployee: Codable {
    let employee: Employee
    let errorModel: AddEmployeeError
}

struct AddEmployeeProperties: Codable {
    let guidID: String
    let recordID: Int
    let employeeName, employeeSurname, department, employeeEmail: String

    enum CodingKeys: String, CodingKey {
        case guidID = "guidId"
        case recordID = "recordId"
        case employeeName, employeeSurname, department, employeeEmail
    }
}

struct AddEmployeeError: Codable {
    let code, errorModelDescription: String

    enum CodingKeys: String, CodingKey {
        case code
        case errorModelDescription = "description"
    }
}
