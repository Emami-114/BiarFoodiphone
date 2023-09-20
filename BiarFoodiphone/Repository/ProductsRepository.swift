//
//  ProductsRepository.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
class ProductsRepository{
    static let shared = ProductsRepository()
    var products = CurrentValueSubject<[Product],Never>([])
    var detailProducts = CurrentValueSubject<[Product],Never>([])
    
    func fetchProducts(withCategories id: String){
        FirebaseManager.shared.database.collection("produkten")
            .whereField("isPublic", isEqualTo: true)
            .whereField("categorie", arrayContains: id)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let document = querySnapshot?.documents else {
                    print("Fehler beim laden Produkten")
                    return
                }
                
                let products = document.compactMap { queryDocumentSnapshot -> Product? in
                    let product = try? queryDocumentSnapshot.data(as: Product.self)
                    return product
                }
                self.products.send(products)
                
            }
    }
    
}

extension ProductsRepository{
    func fetchDetailProducts(withCategories id: String){
        FirebaseManager.shared.database.collection("produkten")
            .whereField("isPublic", isEqualTo: true)
            .whereField("categorie", arrayContains: id)
            .limit(to: 12)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let document = querySnapshot?.documents else {
                    print("Fehler beim laden Produkten")
                    return
                }
                
                let products = document.compactMap { queryDocumentSnapshot -> Product? in
                    let product = try? queryDocumentSnapshot.data(as: Product.self)
                    return product
                }
                self.detailProducts.send(products)
                
            }
    }
    
    

    
}
