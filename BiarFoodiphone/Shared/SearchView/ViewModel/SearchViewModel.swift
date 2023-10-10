//
//  SearchViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 03/10/2023.
//

import Foundation
import Combine
@MainActor
class SearchViewModel: ObservableObject {
    @Published var categories = [Category]()
    @Published var searchProducts = [Product]()
    @Published var searchText = ""
    let categoryRepository = CategoriesRepository.shared
    let searchRepository = SearchRepository.shared
    var cancellables = Set<AnyCancellable>()
    init(){
        categoryRepository.mainCategories.sink{[weak self] categories in
            guard let self else {return}
            self.categories = categories
        }.store(in: &cancellables)
        
        
    }
    func fetchCategories(){
        DispatchQueue.main.async {
            self.categoryRepository.fetchCategories()

        }
    }
    
    func fetchSearchProducts(query: String)async throws{
        self.searchProducts = try await searchRepository.fetchSearch(query: query)
    }
}
