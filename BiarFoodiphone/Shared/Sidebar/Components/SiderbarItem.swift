//
//  SliderItem.swift
//  BiarFoodiphone
//
//  Created by Ecc on 14/09/2023.
//

import SwiftUI

struct SiderbarItem: View {
    let icon: String
    let title: String
    var body: some View {
        HStack{
            Image(systemName: icon)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color.theme.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 22,height: 22)
            Text(title)
                .font(.title3)
                .foregroundColor(Color.theme.white)
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(.horizontal)
    }
}
