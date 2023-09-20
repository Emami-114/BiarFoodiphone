//
//  CategoriesViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import Foundation
import Combine
class CategorieViewModel: ObservableObject {
    @Published var categories = [Category]()
    private var cancellables = Set<AnyCancellable>()
    
    let categoriesRepository = CategoriesRepository.shared
    
    init(){
        categoriesRepository.categories.dropFirst()
            .sink{[weak self] categories in
                guard let self else {return}
                self.categories = categories
            }
            .store(in: &cancellables)
        
        categoriesRepository.fetchCategories()
    }
    
    
    func filterSubCategories(selectedMain: String) -> [Category] {
        categories.filter { subCategory in
            subCategory.mainId == selectedMain
        }
    }
    
    
}
