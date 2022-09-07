//
//  EmployeesModel.swift
//  VAKIFBANKAPP
//
//  Created by St900512 on 12.08.2022.
//

import Foundation


struct EmployeeResponse: Codable {
    var employeeList: [Employee]
}

struct Employee: Codable {
    let guidId: String
    let recordId: Int
    let employeeName: String
    let employeeSurname: String
    let department: String
    let employeeEmail: String
}
