//
//  Category.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Category : Codable,Hashable {
    @DocumentID var id: String?
    let mainId: String
    let name: String
    let desc: String
    let type: String
    let imageUrl : String
}

struct SubCategory: Codable {
    var id : String = UUID().uuidString
    let mainId: String
    let name: String
    let desc: String
    let type: String
}
