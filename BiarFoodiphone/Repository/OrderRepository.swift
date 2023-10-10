//
//  OrderRepository.swift
//  BiarFoodiphone
//
//  Created by Ecc on 20/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
class OrderRepository {
    static let shared = OrderRepository()
    var listener: ListenerRegistration?
    var orders = CurrentValueSubject<[Invoice],Never>([])
}

extension OrderRepository{
    func createOrder(
        successful: Bool,
        customerName:String,
        customerAdress: String,
        customerZip:String,
        customerCity:String,
        deliveryDate: Date,
        paymentType: String,
        paymentSuccess: Bool,
        products: [InvoiceProduct],
        email: String,
        invoiceNum: String,
        totalPrice: Double,
        deliveryAddressDifferent : Bool,paymentToken: String?){
            guard let userId = FirebaseManager.shared.userId else {return}
            let order = Invoice(
                userId: userId,
                successful: successful,
                customerName: customerName,
                customerAdress: customerAdress,
                customerZip: customerZip,
                customerCity: customerCity,
                deliveryDate: deliveryDate,
                paymentType: paymentType,
                paymentSuccess: paymentSuccess,
                email: email,
                invoiceNum: invoiceNum,
                totalPrice: totalPrice,
                deliveryAddressDifferent : deliveryAddressDifferent,
                products: products,paymentToken: paymentToken)
            
            do{
                try FirebaseManager.shared.database.collection("orders").addDocument(from: order)
            }catch let error{
                print("Fehler beim erstellen von order: \(error.localizedDescription)")
            }
        }
    
    func fetchCartProductId()async throws{
        guard let userId = FirebaseManager.shared.userId else { return }
       let orders =  try await FirebaseManager.shared.database.collection("users").document(userId).collection("cart")
            .getDocumentFromFireStore(as: Invoice.self)
        self.orders.send(orders)
    }
    
    
    func deleteAllCartProduct(indexSet: [String]){
        guard let userId = FirebaseManager.shared.userId else { return }
        let firebaseRef = FirebaseManager.shared.database.collection("users").document(userId).collection("cart")
        indexSet.forEach { proId in
            firebaseRef.document(proId).delete(){error in
                if let error = error {
                    print("Fehler beim user Warenkorb lösen: \(error.localizedDescription)")
                }
            }
        }
    }
}
