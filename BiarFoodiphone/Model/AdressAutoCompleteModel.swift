//
//  AdressAutoCompleteModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 20/09/2023.
//

import Foundation


struct AdressAutoCompleteModel: Codable,Hashable {
    let predictions: [AdressProperties]
}

struct AdressProperties: Codable,Hashable {
    let place_id: String
    let description: String
    let terms: [Terms]
}
struct Terms: Codable,Hashable{
    let offset: Int
    let value: String
}
