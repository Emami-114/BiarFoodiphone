//
//  Order.swift
//  BiarFoodiphone
//
//  Created by Ecc on 20/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Order: Codable{
    @DocumentID var id: String?
    let userId: String
    let successful: Bool
    let customerName: String
    let customerAdress: String
    let customerZip: String
    let customerCity: String
    let deliveryDate: Date?
    let paymentType: String
    let paymentSuccess: Bool
    let products : [OrderProduct]
    var createdAt : Timestamp = Timestamp()

}
struct OrderProduct: Codable{
    let id: String
    let name: String
    let quantity: Int
    let netWeight: String
    let depositType: String?
    let depositPrice: Double?
    let imageUrl: String
    let price: Double
    let tax: Int
    
}
