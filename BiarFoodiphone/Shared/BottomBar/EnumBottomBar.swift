//
//  EnumBottomBar.swift
//  BiarFoodiphone
//
//  Created by Ecc on 11/09/2023.
//

import Foundation
import SwiftUI
enum BottomBar: String,CaseIterable {
    case home
    case search,cart,favorite
    
    var title: String{
        switch self {
        case .home: return "Home"
        case .search:
            return "Suche"
        case .cart:
                return "Warenkorb"
        case .favorite:
            return "Favoriten"
    
        }
    }
    
    var icon: String{
        switch self {
        case .home:
            return "house.fill"
        case .search:
            return "magnifyingglass"
        case .cart:
            return "cart"
        case .favorite:
            return "heart"
        }
    }

//    var view : AnyView {
//        switch self {
//        case .home:
//            return AnyView(HomeView(sidbarShowing: .constant(false)))
//        case .search:
//            return AnyView(Text("search View"))
//        case .cart:
//            return AnyView(Text("Cart View"))
//        case .favorite:
//            return AnyView(Text("Favorite View"))
//        case .account:
//            return AnyView(Text("Account View"))
//        }
//    }
}
