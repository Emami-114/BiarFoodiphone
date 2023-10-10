//
//  ColorTheme.swift
//  BiarFoodiphone
//
//  Created by Ecc on 12/09/2023.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = ColorTheme()
}

struct ColorTheme{
    let greenColor = Color("Green")
    let backgroundColor = Color("BackgroundColor")
    let blackColor = Color("Black")
    let iconColor = Color("IconColor")
    let subTextColor = Color("SubText")
    let white = Color("White")
    let greenBlack = Color("GreenBlack")
    let linearGradient = LinearGradient(colors: [
        Color("Green").opacity(0.9),
        Color("Green"),
        Color("Green").opacity(0.9),
    ], startPoint: .topLeading, endPoint: .bottomTrailing)
}
