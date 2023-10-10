//
//  responsiveView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 29/08/2023.
//

import SwiftUI

struct responsiveView<Content: View> : View {
    let content: (Properties) -> Content
    init(@ViewBuilder content: @escaping (Properties) -> Content) {
        self.content = content
    }
    var body: some View {
        GeometryReader{proxy in
            let size = proxy.size
            let isLandscape = size.width > size.height
            let isIpad = UIDevice.current.userInterfaceIdiom == .pad
            let isCompat = (UIDevice.current.userInterfaceIdiom == .phone) != isLandscape
            content(Properties(isLandscape: isLandscape, isIpad: isIpad, size: size, isCompat: isCompat))
                .frame(width: size.width,height: size.height)
            
        }
    }
}

struct Properties {
    var isLandscape: Bool
    var isIpad: Bool
    var size: CGSize
    var isCompat: Bool
}
