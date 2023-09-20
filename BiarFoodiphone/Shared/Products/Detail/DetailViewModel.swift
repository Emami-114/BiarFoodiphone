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
    @Published var userIsLogged = false
    @Published var products = [Product]()
    private var cancellables = Set<AnyCancellable>()
     @Published var FavoriteId: String = ""
    
    init(){
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
