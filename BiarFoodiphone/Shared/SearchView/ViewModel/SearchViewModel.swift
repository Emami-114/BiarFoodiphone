//
//  SearchViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 03/10/2023.
//

import Foundation
import Combine
class SearchViewModel: ObservableObject {
    @Published var categories = [Category]()
    let categoryRepository = CategoriesRepository.shared
    var cancellables = Set<AnyCancellable>()
    init(){
        categoryRepository.mainCategories.sink{[weak self] categories in
            guard let self else {return}
            self.categories = categories
        }.store(in: &cancellables)
        
        
        fetchCategories()
    }
    
    func fetchCategories(){
        categoryRepository.fetchCategories()
    }
}
