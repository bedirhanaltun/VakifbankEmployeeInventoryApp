import Foundation


struct EmployeeCheck: Codable{
    var id: Int
}

struct EmployeeProductList: Codable {
    let employeeProductList: [EmployeeProduct]?
}

struct EmployeeProduct: Codable{
    let guidId: String
    let productId: Int
    let pairId: Int
    let recordId: Int
    var name: String?
}

struct EmployeeProductError: Codable{
    let code: String
    let description: String
}
