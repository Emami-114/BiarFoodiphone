//
//  User.swift
//  BiarFoodiphone
//
//  Created by Ecc on 31/08/2023.
//

import Foundation
import Firebase
struct User:Codable {
    var id: String
    var salutation: String
    var firstName: String
    var lastName: String
    var street: String
    var houseNumBer : String
    var zipCode : String
    var email: String
    var rolle: String
    var emailConfirm: Bool
    var phoneNumber: String
    var city: String
    var country: String
    var registerAt: Timestamp = Timestamp()
}
