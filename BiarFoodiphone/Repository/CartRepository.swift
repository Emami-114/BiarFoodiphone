//
//  CartRepository.swift
//  BiarFoodiphone
//
//  Created by Ecc on 15/09/2023.
//

import Foundation
import Foundation
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class CartRepository {
    static let shared = CartRepository()
    var listener: ListenerRegistration?
    var cartProductsId = CurrentValueSubject<[CartModel],Never>([])
//    var singleCartProductId = CurrentValueSubject<CartModel?,Never>(nil)
    var cartProducts = CurrentValueSubject<[Product],Never>([])

}

extension CartRepository {
    func addCartProductId(productId: String) {
        guard let userId = FirebaseManager.shared.userId else { return }
        let product = CartModel(productId: productId,quantity: 1)
        
        do {
            try FirebaseManager.shared.database.collection("users").document(userId).collection("cart")
                .document(productId).setData(from: product)
        }catch let error {
            print("Fehler beim Speicher Favoriten: \(error.localizedDescription)")
        }
    }
    
    
    func updateCardProductId(productId: String,quantity: Int) {
        guard let userId = FirebaseManager.shared.userId else { return }
        let product = ["quantity": quantity]
        
        FirebaseManager.shared.database.collection("users").document(userId).collection("cart").document(productId).setData(product, merge: true){error in
            if let error = error {
                print("Fehler beim Updaten: \(error.localizedDescription)")
            }
        }
    }
    
    
    func fetchCartProductIdSingle(with id: String,productCart: @escaping (_ data: CartModel) -> ()){
        guard let userId = FirebaseManager.shared.userId else { return}
         FirebaseManager.shared.database.collection("users").document(userId).collection("cart").document(id).getDocument(completion: { document, error in
            if let error = error {
                print("Fetching Faorite failed: \(error.localizedDescription)")
                return
            }
            
            guard let document else {
                print("Dukument existiert nicht!")
                return
            }
            
            do {
                let productId = try document.data(as: CartModel.self)
                productCart(productId)
            }catch{
                print("Dokument is kein Favorite: \(error.localizedDescription)")
            }
        })

        
    }
    
    
    func fetchCartProductId(){
        guard let userId = FirebaseManager.shared.userId else { return }
        FirebaseManager.shared.database.collection("users").document(userId).collection("cart")
            .addSnapshotListener({ querySnapshot, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("Fehler beim Laden der Favorit produkten")
                    return
                }
                
                let productsId = documents.compactMap { queryDocument -> CartModel? in
                    return try? queryDocument.data(as: CartModel.self)
                }
                self.cartProductsId.send(productsId)
            })
    }
    
    
    
    
    func deleteCartProduct(with id: String){
        guard let userId = FirebaseManager.shared.userId else { return }
        FirebaseManager.shared.database.collection("users").document(userId).collection("cart")
            .document(id).delete()
    }
    
    func removeListener() {
        self.cartProducts.send([])
        self.listener?.remove()
        self.fetchCartProductId()
        
    }
    
    
    func fetchCartProducts(productsId: [String]){
        FirebaseManager.shared.database.collection("produkten")
            .whereField("isPublic", isEqualTo: true)
            .whereField("productId", in: productsId)
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
                self.cartProducts.send(products)
                
            }
    }
    
}


