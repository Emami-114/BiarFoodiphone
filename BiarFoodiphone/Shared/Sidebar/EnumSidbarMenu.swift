//
//  EnumSidbarMenu.swift
//  BiarFoodiphone
//
//  Created by Ecc on 29/08/2023.
//

import Foundation
enum EnumSidbarMenu: CaseIterable {
case account
case order
case notifications
case help
case privacy
case imprint
}

enum EnumSidbarMenuIpad: CaseIterable {
    case home,search,cart,favorite
    var title: String{
        switch self {
        case .home: return Strings.home
        case .search:
            return Strings.search
        case .cart:
            return Strings.shoppingCart
        case .favorite:
            return Strings.favoritSeit
      
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
}
