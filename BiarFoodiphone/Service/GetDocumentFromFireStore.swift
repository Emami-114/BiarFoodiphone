//
//  GetDocumentFromFireStore.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
extension Query{
    func getDocumentFromFireStore<T>(as type: T.Type) async throws -> [T] where T: Decodable {
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.compactMap({ document in
            try document.data(as: T.self)
        })
    }
}
