//
//  ScreenTimeline.swift
//  BiarFoodiphone
//
//  Created by Ecc on 18/09/2023.
//

import SwiftUI

struct ScreenTimeline: View {
    @EnvironmentObject var viewModel : OrderViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 150,height: 2)
            HStack(alignment: .center,spacing: 30){
                ForEach(OrderEnum.allCases,id: \.self) { order in
                        Circle().fill(
                             viewModel.currentView.id == order.id ? Color.theme.greenColor : Color.theme.white)
                            .frame(minWidth: 40,maxWidth: 40)
                            .overlay {
                                Text("\(order.id)")
                                    .font(.title.bold())
                                    .foregroundColor(viewModel.currentView.id == order.id ? Color.theme.white : Color.theme.iconColor)
                            }
                }
            }
        }
    }
}

#Preview {
    ScreenTimeline()
        .environmentObject(OrderViewModel(products: [], totalPrice: 0.0))
}
