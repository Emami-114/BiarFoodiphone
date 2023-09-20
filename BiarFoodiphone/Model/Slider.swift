//
//  Slider.swift
//  BiarFoodiphone
//
//  Created by Ecc on 12/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Slider : Codable,Identifiable{
    @DocumentID var id: String?
    let title: String
    let desc: String
    let imageUrl: String
    var isPublich: Bool
    var createdAt: Timestamp = Timestamp()
}
