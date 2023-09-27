//
//  DetailViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 02/09/2023.
//

import Foundation
import Combine
class DetailViewModel : ObservableObject {
    @Published var selectedTab = "Für Dish"
    let productsRepository = ProductsRepository.shared
    let favoriteRepository = FavoriteRepository.shared
    let userRepository = UserRepository.shared
    @Published var cartProductId = [CartModel]()
    @Published var loading = false
    @Published var userIsLogged = false
    @Published var products = [Product]()
    private var cancellables = Set<AnyCancellable>()
     @Published var FavoriteId: String = ""
    let cartRepository = CartRepository.shared

    init(){
        cartRepository.cartProductsId.sink{[weak self] productId in
            guard let self else {return}
            self.cartProductId = productId
        }.store(in: &cancellables)
        
        productsRepository.detailProducts
            .sink{[weak self] products in
                guard let self else {return}
                self.products = products
            }
            .store(in: &cancellables)
        
        favoriteRepository.singleFavoriteproduct
            .sink{[weak self] favorite in
                guard let self else {return}
                self.FavoriteId = favorite?.productId ?? ""
            }
            .store(in: &cancellables)
        
        userRepository.userIsLoggedIn.sink{self.userIsLogged = $0}
            .store(in: &cancellables)
    }
    func isProductOnCartQuantity(productId: String) -> Int{
        cartProductId.filter { Id in
            Id.productId == productId
        }.first?.quantity ?? 0
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
    
    func isFavorite(id: String) -> Bool{
        self.FavoriteId == id
    }
    
    func fetchDetailProducts(with categoryId: String){
        productsRepository.fetchDetailProducts(withCategories: categoryId)
    }
    
    func fetchFavoriteSingle(with id: String){
        favoriteRepository.fetchUserFavoriteSingle(with: id)
    }
    
    func addUserFavorite(productId: String,productName: String){
            favoriteRepository.addUserFavorite(productId: productId, productName: productName)
            fetchFavoriteSingle(with: productId)
    }
   
    func favoriteDelete(with id: String) {
        favoriteRepository.deleteUserFavorite(with: id)
        favoriteRepository.singleFavoriteproduct.send(nil)
        self.FavoriteId = ""
        fetchFavoriteSingle(with: id)

    }
}
