//
//  FavoriteRepository.swift
//  BiarFoodiphone
//
//  Created by Ecc on 14/09/2023.
//

import Foundation
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
class FavoriteRepository {
    static let shared = FavoriteRepository()
    var listener: ListenerRegistration?
    var favoriteproducts = CurrentValueSubject<[FavoriteModel],Never>([])
    var products = CurrentValueSubject<[Product],Never>([])
    var singleFavoriteproduct = CurrentValueSubject<FavoriteModel?,Never>(nil)

}

extension FavoriteRepository {
    func addUserFavorite(productId: String,productName: String) {
        guard let userId = FirebaseManager.shared.userId else { return }
        let favorite = FavoriteModel(productId: productId, productName: productName)
        
        do {
            try FirebaseManager.shared.database.collection("users").document(userId).collection("favorit")
                .document(productId).setData(from: favorite)
        }catch let error {
            print("Fehler beim Speicher Favoriten: \(error.localizedDescription)")
        }
        
    }
    
    
    func fetchUserFavoriteSingle(with id: String){
        guard let userId = FirebaseManager.shared.userId else { return }
         FirebaseManager.shared.database.collection("users").document(userId).collection("favorit").document(id).getDocument(completion: { document, error in
            if let error = error {
                print("Fetching Faorite failed: \(error.localizedDescription)")
                return
            }
            
            guard let document else {
                print("Dukument existiert nicht!")
                return
            }
            
            do {
                let favorite = try document.data(as: FavoriteModel.self)
                self.singleFavoriteproduct.send(favorite)
            }catch{
                print("Dokument is kein Favorite: \(error.localizedDescription)")
            }
        })

        
    }
    
    
    func fetchUserFavorite(){
        guard let userId = FirebaseManager.shared.userId else { return }
        self.listener = FirebaseManager.shared.database.collection("users").document(userId).collection("favorit")
            .addSnapshotListener({ querySnapshot, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    print("Fehler beim Laden der Favorit produkten")
                    return
                }
                let products = documents.compactMap { queryDocument -> FavoriteModel? in
                    return try? queryDocument.data(as: FavoriteModel.self)
                }
                self.favoriteproducts.send(products)
            })
    }
    
    func deleteUserFavorite(with id: String){
        guard let userId = FirebaseManager.shared.userId else { return }
        FirebaseManager.shared.database.collection("users").document(userId).collection("favorit")
            .document(id).delete()
    }
    
    func removeListener() {
        self.favoriteproducts.send([])
        self.listener?.remove()
    }
    
    
    func fetchFavoriteProducts(productsId: [String]){
        FirebaseManager.shared.database.collection("produkten")
            .whereField("isPublic", isEqualTo: true)
            .whereField("id", in: productsId)
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

