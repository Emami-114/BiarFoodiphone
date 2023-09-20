//
//  OrderView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 18/09/2023.
//

import SwiftUI

struct OrderView: View {
    @StateObject private var viewModel = OrderViewModel()
    var body: some View {
        ZStack(alignment: .top){
            Color.theme.backgroundColor
                .ignoresSafeArea(.all,edges: .all)
            VStack(spacing: 20){
            ScreenTimeline()
                
                viewModel.view
                    .padding(.top)
                Spacer()
                Button{
                        if viewModel.currentView == .adress{
                            viewModel.currentView = .deliverytime
                        }else {
                            viewModel.currentView = .payment
                        }
                }label: {
                    Text(viewModel.currentView == .payment ? "Bezahlen" : "Nächste")
                        .font(.title2)
                        .foregroundColor(Color.theme.white)
                        .frame(width: 300,height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.theme.greenColor))
                }
            }
        }
        .environmentObject(viewModel)
        .animation(.easeInOut(duration: 0.5), value: viewModel.currentView)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(OrderViewModel())
    }
}
