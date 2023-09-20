//
//  SignInViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 31/08/2023.
//

import Foundation
class SigninViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var loading = false
    let userRepository = UserRepository.shared
    
    
    var disableAuthenticationButton : Bool{
        email.isEmpty || password.isEmpty
    }
    
    func login(){
        loading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            self.userRepository.login(email: self.email, password: self.password)
                self.loading = false
        }
    }
    
}
