//
//  SidbarViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 14/09/2023.
//

import Foundation
import Combine
import SwiftUI
class SidbarViewModel : ObservableObject{
    @Published var currentItem : EnumSidbarMenu? = nil
    let userRepository = UserRepository.shared
    @Published var userIsLoggedIn = false
    private var cancellables = Set<AnyCancellable>()
    
     var view: AnyView {
        switch self.currentItem{
        case .account: return AnyView(AuthenticationView())
        case .order: return AnyView(Text("Bestellungemn"))
        case .help: return AnyView(Text(""))
        case .imprint: return AnyView(Text(""))
        case .notifications: return AnyView(Text(""))
        case .privacy: return AnyView(Text(""))
        case .myAdress: return AnyView(ProfileAdresse(dismiss: {self.currentItem = nil}))
        case .none: return AnyView(Text(""))
        }
    }
    init(){
        userRepository.userIsLoggedIn
            .sink { self.userIsLoggedIn = $0 }
            .store(in: &cancellables)
    }
    
    func switchItemTitle(item: EnumSidbarMenu) -> String{
            switch item {
            case .account : return self.userIsLoggedIn ? Strings.account : Strings.login
            case .order : return Strings.orders
            case .notifications: return Strings.notification
            case .help : return Strings.help
            case .privacy : return Strings.dataProtection
            case .imprint : return Strings.imprint
            case .myAdress:
                return ""
            }
   
    }
    
    func switchItemIcon(item: EnumSidbarMenu) -> String{
                switch item {
                case .account : return "person.circle"
                case .order: return "basket"
                case .notifications : return "bell"
                case .help : return "questionmark.bubble"
                case .privacy : return "person.badge.shield.checkmark"
                case .imprint : return "newspaper.fill"
                case .myAdress:
                        return ""
                }
   
    }
    

}
