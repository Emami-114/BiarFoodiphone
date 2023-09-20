//
//  ProductCellViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 15/09/2023.
//

import SwiftUI
import Combine
class ProductCellViewModel: ObservableObject {
    @Published var cartProductId = [CartModel]()
    @Published var userIsLogged = false
    @Published var loading = false
    let cartRepository = CartRepository.shared
    let userRepository = UserRepository.shared
    var cancellable = Set<AnyCancellable>()
    
    init(){
        cartRepository.cartProductsId.sink{[weak self] productId in
            guard let self else {return}
            self.cartProductId = productId
        }.store(in: &cancellable)
        
        userRepository.userIsLoggedIn.sink{self.userIsLogged = $0}
            .store(in: &cancellable)
        
//        fetchCartProductsId()
    }
    
    func isProductOnCart(productId: String) -> Bool{
      cartProductId.contains(where: { proId in
            proId.productId == productId
        })
        
    }
    func quantityPlus(with id: String){
        
        let productCount = cartProductId.filter { proId in
            proId.productId == id
        }.first
        
        guard let singleProductId = productCount?.quantity else {return}

        
        cartRepository.updateCardProductId(productId: id, quantity: singleProductId + 1)
        fetchCartProductsId()
    }
    
    func quantityminus(with id: String){
        let productCount = cartProductId.filter { proId in
            proId.productId == id
        }.first
        guard let singleProductId = productCount?.quantity else {return}
        
        if singleProductId > 1{
            cartRepository.updateCardProductId(productId: id, quantity: singleProductId-1)
            fetchCartProductsId()
        }else{
            cartRepository.deleteCartProduct(with: id)
            fetchCartProductsId()
        }
        
    }
    
    func fetchCartProductsId(){
        cartRepository.fetchCartProductId()
    }

    func addCartProductId(with productId: String){
        self.loading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            self.cartRepository.addCartProductId(productId: productId)
            self.fetchCartProductsId()
            self.loading = false
            
        }
    }
}
