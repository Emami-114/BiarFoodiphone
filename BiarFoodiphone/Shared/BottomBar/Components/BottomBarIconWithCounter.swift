//
//  BottomBarIconWithCounter.swift
//  BiarFoodiphone
//
//  Created by Ecc on 21/09/2023.
//

import SwiftUI

struct BottomBarIconWithCounter: View {
    let icon: String
    let title: String
     var action : () -> Void
    @Binding var cartCount : Int
    @EnvironmentObject var viewModel: BottomBarViewModel
    var nameSpace: Namespace.ID
     var isCart: Bool = false
    var body: some View {
        Button{
            withAnimation(.spring){
                action()
            }
        }label: {
            HStack{
                    if title == viewModel.currentItem.title {
                        Text(title)
                    }
                    Image(systemName: icon)
                        .overlay(alignment: .topTrailing) {
                            if cartCount > 0 {
                                Text(String(cartCount))
                                    .padding(3)
                                    .font(.caption2)
                                    .foregroundColor(Color.theme.white)
                                    .background(Circle().fill(.red))
                                    .offset(x: 5,y: -9)
                            }
                        }
            }
            .foregroundColor(title == viewModel.currentItem.title ? .white : .black)
                .padding()
                .frame(height: 55)
                .background{
                    if title == viewModel.currentItem.title{
                        Rectangle().fill(title == viewModel.currentItem.title ? Color.theme.greenColor : .clear)
                            .roundedCornerView(corners: [.topLeft,.bottomRight], radius: 20)
                            .matchedGeometryEffect(id: "bottomBar", in: nameSpace)
                            .shadow(radius: 3)
                    }
                }
                .offset(y: -5)
        }
        .animation(.spring(), value: self.title)

    }
}
