//
//  ProductsViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import Foundation
import Combine
class ProductsViewModel: ObservableObject {
    @Published var products = [Product]()
    @Published var productOnCart = 0
    private var cancellables = Set<AnyCancellable>()
    @Published var selectedCategorie: String = ""
    @Published var selectedSubCategorie = ""

    let productsRepository = ProductsRepository.shared
    let cartRepository = CartRepository.shared
    
    init(){
        productsRepository.products.dropFirst()
            .sink{[weak self] products in
                guard let self else {return}
                self.products = products
            }
            .store(in: &cancellables)
            fetchProducts()
        
        cartRepository.cartProductsId.sink{[weak self] cartProducts in
            guard let self else {return}
            self.productOnCart = cartProducts.count
        }
        .store(in: &cancellables)
    }
    
    
    func productesFilter(subCategorie : String) -> [Product] {
        products.filter { product in
            product.categorie.contains { string in
                string == subCategorie
            }
        }
    }
    
    
    func fetchProducts(){
        productsRepository.fetchProducts(withCategories: selectedCategorie)

    }
    
    
    
}
