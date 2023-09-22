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
    @Published var favoritsCounter : Int = 0
    
    let cartRepository = CartRepository.shared
    let favoritsRepository = FavoriteRepository.shared
    var cancellable = Set<AnyCancellable>()
    init(){
        cartRepository.cartProductsId.sink{[weak self] cartCoun in
            guard let self else {return}
            self.cartCounter = cartCoun.count
        }
        .store(in: &cancellable)
        favoritsRepository.favoriteproducts.sink{self.favoritsCounter = $0.count}
            .store(in: &cancellable)
    }
    @MainActor
    func buttonBarChange(bottomBar: BottomBar){
        
        DispatchQueue.main.async {
            Task{
            withAnimation(.easeInOut(duration: 0.4)){
                    self.currentItem = bottomBar
                }
            }
        }
    }
    
    func fetchCartCount(){
        cartRepository.fetchCartProductId()
    }
    
    func fetchFavoritsCount(){
        favoritsRepository.fetchUserFavorite()
    }
}
