//
//  SignInViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 31/08/2023.
//

import Foundation
import Combine
class SigninViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var error: String? = nil
    @Published var password: String = ""
    @Published var loading = false
    @Published var showAlert = false
    @Published var userIsLogged = false

    let userRepository = UserRepository.shared
    private var cancellable = Set<AnyCancellable>()
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
    
    
    func errorRemove(){
        userRepository.authError.send(nil)
        self.error = nil
        self.showAlert = false
    }
    
    var disableAuthenticationButton : Bool{
        email.isEmpty || password.isEmpty
    }
    
    func login(){
        loading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+1.2){
            self.loading = false
            self.userRepository.login(email: self.email, password: self.password)
                
        }
    }
    
}
