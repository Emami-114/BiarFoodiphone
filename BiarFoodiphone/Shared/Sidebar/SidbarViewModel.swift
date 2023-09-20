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
        case .account: return self.userIsLoggedIn ? AnyView(MeinProfile(dismiss: {self.currentItem = nil})) : AnyView( AuthenticationView())
        case .order: return AnyView(Text("Bestellungemn"))
        case .help: return AnyView(Text(""))
        case .imprint: return AnyView(Text(""))
        case .notifications: return AnyView(Text(""))
        case .privacy: return AnyView(Text(""))
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
            case .account : return self.userIsLoggedIn ? "Konto" : "Anmelden"
            case .order : return "Bestellungen"
            case .notifications: return "Push"
            case .help : return "Hilfe"
            case .privacy : return "Datenschutz"
            case .imprint : return "Impressum"
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
        
                }
   
    }
    

}
