//
//  AdressAutocomplete.swift
//  BiarFoodiphone
//
//  Created by Ecc on 20/09/2023.
//

import Foundation
import Combine
class AdressAutocompleteRepository {
    static let shared = AdressAutocompleteRepository()
    
    let apiKey = "AIzaSyACp8cg1iEV7EeH7mK9Z22rMtpciz8S4lI"
    
     func autoCompletet(input: String) async throws -> [AdressProperties] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "maps.googleapis.com"
        components.path = "/maps/api/place/autocomplete/json"
        components.queryItems = [
        URLQueryItem(name: "input", value: input),
        URLQueryItem(name: "apiKey", value: apiKey),
        ]
//        guard let url = components.url else {
//            throw ErrorEnum.invalidURL
//        }
        
        guard let url2 = URL(string:"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(input)&language=de&key=AIzaSyACp8cg1iEV7EeH7mK9Z22rMtpciz8S4lI") else {
            throw ErrorEnum.invalidURL
        }
        let (data,_) = try await URLSession.shared.data(from: url2)
        let result = try JSONDecoder().decode(AdressAutoCompleteModel.self, from: data)
        return result.predictions
    }
    
}
