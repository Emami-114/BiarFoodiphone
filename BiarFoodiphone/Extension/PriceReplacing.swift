//
//  PriceReplacing.swift
//  BiarFoodiphone
//
//  Created by Ecc on 16/09/2023.
//

import Foundation
func PriceReplacing(price: Double) -> String{
    let priceString = String(format: "%.2f", price)
    let priceReplacing = priceString.replacingOccurrences(of: ".", with: ",")
    return priceReplacing
}
