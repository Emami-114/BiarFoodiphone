//
//  Product.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Product:Codable,Hashable{
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


    var productExample: Product = Product(title: "Coca-Cola 2l", desc: "koffeinhaltiges Erfrischungsgetränk mit Pflanzenextrakten", price: 2, categorie: [], brand: "",sale: true, salePrice: 1.0, unit: "ml", imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/biarfood-77cad.appspot.com/o/product_images%2FD3E4D04A-663D-4CB1-8EC2-19D98022877E?alt=media&token=daf2b338-278a-464b-90c9-d65ab0d40e72", unitAmountPrice: "(1 l = 0,95 €)", tax: 0, articleNumber: "6729673", available: false, availableAmount: 0, deposit: true, depositType: "", depositPrice: 3.30, netFillingQuantity: "330", alcoholicContent: "", nutriScore: "", ingredientsAndAlegy: "", madeIn: "Kontaktname: Coca-Cola European Partners Deutschland GmbH Kontaktadresse: Postfach 67 01 56, 10207 Berlin", referencePoint: "", calorificKJ: "", caloricValueKcal: "", fat: "", fatFromSour: "", carbohydrates: "", CarbohydratesFromSugar: "", protein: "", salt: "", additionallyWert: "",isCold: true,isPublic: true,adult: true,minimumAge: 19)

