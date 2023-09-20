//
//  SignUpViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 31/08/2023.
//

import Foundation
class SignupViewModel: ObservableObject {
    @Published var salutation: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var street: String = ""
    @Published var houseNumBer : String = ""
    @Published var zipCode : String = ""
    @Published var email: String = ""
    @Published var password = ""
    @Published var passwordReentry = ""
    @Published var rolle = "Kunden"
    @Published var emailConfirm = false
    @Published var phoneNumber = ""
    @Published var country = ""
    @Published var city = ""
    let userRepository = UserRepository.shared
    
    
    
    var disableAuthenticationButton: Bool {
        email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty || passwordReentry.isEmpty || (password != passwordReentry)
    }
    
    
    func register() {
        userRepository.register(email: email, password: password, salutation: salutation, firstName: firstName, lastName: lastName, street: street, houseNumBer: houseNumBer, zipCode: zipCode,rolle: rolle,emailConfirm: emailConfirm,phoneNumber: phoneNumber,country: country, city: city)
    }
}

