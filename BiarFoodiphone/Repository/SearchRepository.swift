//
//  SearchRepository.swift
//  BiarFoodiphone
//
//  Created by Ecc on 10/10/2023.
//

import Foundation
import SwiftUI
import Kingfisher
class SearchRepository {
    static let shared = SearchRepository()
    
    func fetchSearch(query: String) async throws -> [Product] {
        try await FirebaseManager.shared.database.collection("produkten")
            .whereFilter(.whereField("title", isGreaterOrEqualTo: query))
            .order(by: "title", descending: false)
            .getDocumentFromFireStore(as: Product.self)
    }
}
