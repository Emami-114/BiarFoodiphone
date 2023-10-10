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
    @Published var categories = [Category]()
    @Published var mainCategories = [Category]()
    @Published var subCategories = [Category]()
    
    @Published var productOnCart = 0
    @Published var selectedProduct: Product? = nil
    @Published var startAnimation: Bool = false
    private var cancellables = Set<AnyCancellable>()
    @Published var selectedCategorie: String = ""
    @Published var selectedSubCategorie = ""

    let productsRepository = ProductsRepository.shared
    let cartRepository = CartRepository.shared
    let categorieRepository = CategoriesRepository.shared
    
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
        
        categorieRepository.categories.sink{[weak self] categories in
            guard let self else {return}
            self.categories = categories
            self.mainCategories = categories.filter({ catgory in
                catgory.type == "Main"
            })
        }.store(in: &cancellables)
    }
    
    func filterSubCategories(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
            self.subCategories = self.categories.filter { category in
                category.mainId == self.selectedCategorie
            }
            self.selectedSubCategorie = self.subCategories.first?.id ?? ""
        }
      
    }
    
    func productesFilter(subCategorie : String) -> [Product] {
        products.filter { product in
            product.categorie.contains { string in
                string == subCategorie
            }
        }
    }
    
    
    
    func fetchProducts(){
        DispatchQueue.main.async {
            Task{
                self.productsRepository.fetchProducts(withCategories: self.selectedCategorie)
            }
        }

    }
    
    
    
}
