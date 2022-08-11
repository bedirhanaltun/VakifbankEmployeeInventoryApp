//
//  LoginModels.swift
//  VAKIFBANKAPP
//
//  Created by St900512 on 11.08.2022.
//

import Foundation

struct LoginCheckRequest: Encodable {
    let checkUsername: String
    let checkPassword: String
}

struct LoginCheckReponse: Decodable {
    let checkForLogin: Bool
    let errorModel: ErrorModel?
}

struct ErrorModel: Decodable {
    let code: String?
    let description: String?
}
