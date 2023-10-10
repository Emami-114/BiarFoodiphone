//
//  SiderbarIpadViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 22/09/2023.
//

import Foundation
import Combine
import SwiftUI
class SiderbarIpadViewModel : ObservableObject{
    @Published var currentItem : String = Strings.home
    @Published var currentItemKonto : String = Strings.account
    let userRepository = UserRepository.shared
    @Published var userIsLoggedIn = false
    private var cancellables = Set<AnyCancellable>()
    
    var view: AnyView {
       switch self.currentItemKonto{
       case Strings.account: return AnyView(AuthenticationView())
       case Strings.orders: return AnyView(Text("Bestellungemn"))
       case Strings.help: return AnyView(Text("dfvedfv"))
       case Strings.imprint: return AnyView(Text("erveverv"))
       case Strings.notification: return AnyView(Text("erverv"))
       case Strings.dataProtection: return AnyView(Text("rverve"))
 
       default:
         return  AnyView(Text(""))
       }
   }

    func switchItemTitle(item: EnumSidbarMenu) -> String{
            switch item {
            case .account : return Strings.account
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
