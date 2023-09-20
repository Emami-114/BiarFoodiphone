//
//  DefaultTextField.swift
//  BiarFoodiphone
//
//  Created by Ecc on 13/09/2023.
//

import SwiftUI

struct DefaultTextField: ViewModifier {
    @FocusState var focusState
    let lineLimit : Int
    let padding: CGFloat
    let frameHeight: CGFloat
    let color: Color
    let focusColor: Color
    let cornerRadius: CGFloat
    let paddingHorizontal : CGFloat
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .foregroundColor(Color.theme.iconColor)
            .autocorrectionDisabled(true)
            .focused($focusState)
            .padding(.horizontal,padding)
            .frame(height: frameHeight)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(focusState ? focusColor : color)
                   
            )
            
            .cornerRadius(cornerRadius)
            .overlay(content: {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: focusState ? 0 : 0.3).fill(Color.theme.subTextColor.opacity(0.3))
            })
            .padding(.horizontal,paddingHorizontal)
            .shadow(color:Color.theme.blackColor.opacity(0.2),radius: focusState ? 8 : 0)
            
            .animation(.spring(), value: self.focusState)
    }
}

extension View {
    func DefaultTextFieldModifier(lineLimit : Int = 1,padding: CGFloat = 20,frameHeight: CGFloat = 50,color: Color = Color.theme.backgroundColor,focusColor : Color = Color.theme.white,cornerRadius: CGFloat = 10,paddingHorizontal: CGFloat = 20) -> some View {
        modifier(DefaultTextField(lineLimit: lineLimit, padding: padding, frameHeight: frameHeight, color: color, focusColor: focusColor,cornerRadius: cornerRadius,paddingHorizontal: paddingHorizontal))
    }
}
