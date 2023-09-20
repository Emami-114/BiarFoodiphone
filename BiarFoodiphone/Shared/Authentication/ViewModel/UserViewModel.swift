//
//  UserViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 31/08/2023.
//

import Foundation
import Combine
import SwiftUI

class UserViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    let userRepository = UserRepository.shared
    let favoriteRepository = FavoriteRepository.shared
    let cartRepository = CartRepository.shared
    @Published var currentAuthView: AuthViewEnum = .signIn
    
    @Published var userIsLogged = false
    @Published var salutation: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var street: String = ""
    @Published var houseNumBer : String = ""
    @Published var zipCode : String = ""
    @Published var email: String = ""
    
    init() {
        userRepository.userIsLoggedIn
            .sink{ self.userIsLogged = $0 }
            .store(in: &cancellables)
        
        userRepository.user
            .sink { [weak self] user in
                guard let self, let user else { return }
                
                self.salutation = user.salutation
                self.firstName = user.firstName
                self.lastName = user.lastName
                self.street = user.street
                self.houseNumBer = user.houseNumBer
                self.zipCode = user.zipCode
                self.email = user.zipCode
            }
            .store(in: &cancellables)
    }
    
    
     var viewChangeSignUp : AuthViewEnum {
        if self.currentAuthView == .signUp{
            return .signIn
        }else{
            return .signUp
        }
    }
    var viewChangeForgot : AuthViewEnum {
       if self.currentAuthView == .forgotPassword{
           return .signIn
       }else{
           return .forgotPassword
       }
   }
    
    
    
    func logOut(){
        userRepository.logOut()
        favoriteRepository.removeListener()
        cartRepository.removeListener()
        cartRepository.cartProducts.send([])
        cartRepository.cartProductsId.send([])
    }
    
}


enum AuthViewEnum: String,CaseIterable{
    case signIn,signUp,forgotPassword
    
    var title: String{
        switch self {
        case .signIn: return "Anmelden"
        case .signUp:
            return "Registrieren"
        case .forgotPassword:
                return "Password vergessen"
       
        }
    }
    
    var view: AnyView {
        switch self{
        case .signIn:
           return AnyView(SignInView())
        case .signUp:
            return AnyView(SignUpView())
        case .forgotPassword:
            return AnyView(Text("wewfwef"))
        }
    }
}
