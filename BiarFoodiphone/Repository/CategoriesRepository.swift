//
//  CategoriesRepository.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
class CategoriesRepository {
    static let shared = CategoriesRepository()
    var categories = CurrentValueSubject<[Category],Never>([])
    var mainCategories = CurrentValueSubject<[Category],Never>([])
    
    
    func fetchCategories(){
        FirebaseManager.shared.database.collection("categories")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let document = querySnapshot?.documents else {
                    print("Fehler beim laden Categories")
                    return
                }
                
                let categories = document.compactMap { queryDocument -> Category? in
                    let category = try? queryDocument.data(as: Category.self)
                    return category
                }
                
                self.categories.send(categories)
                self.mainCategories.send(categories.filter({ catgory in
                    catgory.type == "Main"
                }))
            }
    }
    
}


