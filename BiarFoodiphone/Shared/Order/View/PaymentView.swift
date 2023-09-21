//
//  PaymentView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 19/09/2023.
//

import SwiftUI

struct PaymentView: View {
    @EnvironmentObject var viewModel: OrderViewModel
    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            PaymentSelected(icon: "cash-payment", paymentEnum: .cash) {
                viewModel.payment = .cash
            }
            
            PaymentSelected(icon: "paypalLogo", paymentEnum: .paypal) {
                viewModel.payment = .paypal
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func PaymentSelected(icon: String,paymentEnum: PaymentEnum,action: @escaping () -> Void) -> some View {
        Button{
            withAnimation(.spring()) {
                action()
            }
        }label: {
            HStack{
                Image(icon)
                    .resizable()
                    .frame(width: 120,height: 40)
                Spacer()
                if viewModel.payment == paymentEnum {
                    Image(systemName: "checkmark.circle")
                        .font(.title)
                        .foregroundColor(Color.theme.greenColor)
                }
            }
        }.padding(.horizontal)
        .frame(width: 300,height: 80,alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 0.5).fill(viewModel.payment == paymentEnum ? Color.theme.greenColor : Color.theme.iconColor))
    }
}

#Preview {
    PaymentView()
        .environmentObject(OrderViewModel(products: []))
}
