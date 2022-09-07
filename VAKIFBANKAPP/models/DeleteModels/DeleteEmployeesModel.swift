

import Foundation

struct DeleteEmployeeCheck: Codable{
    let id: Int
}

struct DeleteEmployee: Codable {
    let employee: Employee?
    let errorModel: DeleteEmployeeError?
}


struct DeleteEmployeeError: Codable {
    let code, errorModelDescription: String

    enum CodingKeys: String, CodingKey {
        case code
        case errorModelDescription = "description"
    }
}
