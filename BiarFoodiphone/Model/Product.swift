//
//  Product.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Product:Codable{
    @DocumentID var id: String?
    let title: String
    let desc: String
    let price: Double
    let categorie: [String]
    let brand: String
    let sale : Bool
    let salePrice: Double
    let unit : String
    let imageUrl: String
    let unitAmountPrice: String
    let tax: Int
    let articleNumber: String
    let available: Bool
    let availableAmount: Int
    let deposit: Bool
    let depositType: String
    let depositPrice: Double
    let netFillingQuantity: String
    let alcoholicContent: String
    let nutriScore: String
    let ingredientsAndAlegy : String
    let madeIn : String
    let referencePoint : String
    let calorificKJ : String
    let caloricValueKcal : String
    let fat: String
    let fatFromSour : String
    let carbohydrates : String
    let CarbohydratesFromSugar: String
    let protein : String
    let salt : String
    var additionallyWert: String
    let isCold: Bool
    let isPublic: Bool
    let adult: Bool
    let minimumAge: Int
    var createdAt : Timestamp = Timestamp()
}
