//
//  BottomBarViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 11/09/2023.
//

import Foundation
import SwiftUI
import Combine

class BottomBarViewModel: ObservableObject {
    @Published var currentItem : BottomBar = .home
    @Published var cartCounter : Int = 0
    @Binding var showSiderBar: Bool
    
    let cartRepository = CartRepository.shared
    var cancellable = Set<AnyCancellable>()
    init(showSiderBar: Binding<Bool>){
        self._showSiderBar = showSiderBar
        cartRepository.cartProductsId.sink{[weak self] cartCoun in
            guard let self else {return}
            self.cartCounter = cartCoun.count
        }
        .store(in: &cancellable)
    }
    
    
    func fetchCartCount(){
        cartRepository.fetchCartProductId()
    }
    
    @MainActor
    var view: AnyView {
        switch currentItem {
        case .home:
            return AnyView(HomeView(sidbarShowing: $showSiderBar))
        case .search:
            return AnyView(Text("search View"))
        case .cart:
            return AnyView(CartsView())
        case .favorite:
            return AnyView(Text("Favorite View"))
       
        case .account:
            return AnyView(Text(""))
        }
    
}
}
