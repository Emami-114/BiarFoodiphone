//
//  FavoriteViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 21/09/2023.
//

import Foundation
import Combine
class FavoriteViewModel: ObservableObject {
    @Published var favorits = [FavoriteModel]()
    @Published var products = [Product]()
    let favoriteRepository = FavoriteRepository.shared
    var cancellable = Set<AnyCancellable>()
    
    init(){
        favoriteRepository.favoriteproducts.sink{[weak self] favorits in
            guard let self else {return}
            self.favorits = favorits
        }
        .store(in: &cancellable)
        
        favoriteRepository.products.sink{[weak self] products in
            guard let self else {return}
            self.products = products
        }
        .store(in: &cancellable)
        
        fetchFavorits()
    }
    
    func fetchFavoriteProducts(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
            if !self.favorits.isEmpty{
                self.favoriteRepository.fetchFavoriteProducts(productsId: self.favorits.compactMap({ favorits in
                    favorits.productId
                }))
            }
        }
    }
    
    func fetchFavorits(){
            favoriteRepository.fetchUserFavorite()
    }
    
    func deleteFavoriteProduct(at offsets: IndexSet){
          offsets.map { favorits[$0] }.forEach { productId in
               let productId = productId.productId
              favoriteRepository.deleteUserFavorite(with: productId)
        }
    }
    
}
