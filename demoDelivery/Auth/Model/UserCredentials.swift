//
//  UserCredentials.swift
//  demoDelivery
//
//  Created by Pavel Mac on 23.07.2025.
//

import Foundation


struct UserCredentials {
    let login: String
    let password: String

    static let validLogin = "1"
    static let validPassword = "1"

    func isValid() -> Bool {
        return login == UserCredentials.validLogin && password == UserCredentials.validPassword
    }
}
