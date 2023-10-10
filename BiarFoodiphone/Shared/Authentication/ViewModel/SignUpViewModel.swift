//
//  SignUpViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 31/08/2023.
//

import Foundation
import Combine
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
    @Published var loading = false
    @Published var showAlert = false
    @Published var userIsLogged = false
    @Published var error: String? = nil
    var cancellable = Set<AnyCancellable>()
    
    init(){
        userRepository.userIsLoggedIn.sink{self.userIsLogged = $0}
            .store(in: &cancellable)
        
        userRepository.authError.sink{error in
            guard let error = error else {return}
            self.error = error
            self.showAlert = true
        }
            .store(in: &cancellable)
    }
    
    
    
    
    func register(action: @escaping () -> Void) {
        loading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            self.userRepository.register(email: self.email, password: self.password, salutation: self.salutation, firstName: self.firstName, lastName: self.lastName, street: self.street, houseNumBer: self.houseNumBer, zipCode: self.zipCode,rolle: self.rolle,emailConfirm: self.emailConfirm,phoneNumber: self.phoneNumber,country: self.country, city: self.city)
            self.loading = false
            action()
        }
    }
    
    var disableAuthenticationButton: Bool {
        email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty || passwordReentry.isEmpty || (password != passwordReentry)
    }
    
    func errorRemove(){
        userRepository.authError.send(nil)
        self.error = nil
        self.showAlert = false
    }
}

