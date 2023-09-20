//
//  GetPercentag.swift
//  BiarFoodiphone
//
//  Created by Ecc on 12/09/2023.
//

import Foundation
import SwiftUI
func getPercentag(geo: GeometryProxy) -> Double {
    let maxDistance = UIScreen.main.bounds.width / 2
    let currentX = geo.frame(in: .global).midX
    return Double(1 - (currentX / maxDistance))
}
