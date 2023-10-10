//
//  OrderView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 18/09/2023.
//

import SwiftUI

struct OrderView: View {
    @StateObject private var orderAdresse = OrderAdressViewModel()
    @ObservedObject private var viewModel : OrderViewModel

    @Environment(\.dismiss) var dismiss
    init(products: [InvoiceProduct],totalPrice: Double){
        self.viewModel = OrderViewModel(
            products: products, totalPrice: totalPrice)
  
    }
    var body: some View {
        ZStack(alignment: .top){
            Color.theme.backgroundColor
                .ignoresSafeArea(.all,edges: .all)
            VStack(spacing: 20){
                CustomNavBarView(title: "Kasse",trillingButtonAction: {}, backButtonAction: {dismiss()})
                
            ScreenTimeline()
                switch viewModel.currentView {
                    case .adress:
                    AnyView(OrderAdress())
                case .deliverytime:
                    AnyView(DeliveryTime())
                case .payment:
                    AnyView(PaymentView(action: {dismiss()}))
                    }

            }
        }
        
        .navigationBarBackButtonHidden(true)
        .environmentObject(viewModel)
        .environmentObject(orderAdresse)
        .animation(.easeInOut(duration: 0.5), value: viewModel.currentView)
      
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(products: [], totalPrice: 0.0)
            .environmentObject(OrderViewModel(products: [], totalPrice: 0.0))
    }
}
