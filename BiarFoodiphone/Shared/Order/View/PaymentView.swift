//
//  PaymentView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 19/09/2023.
//

import SwiftUI

struct PaymentView: View {
    @EnvironmentObject var viewModel: OrderViewModel
    @EnvironmentObject private var orderAdresse : OrderAdressViewModel
    @State private var showAlert = false
    var action: () -> Void
    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            PaymentSelected(icon: "cashonly", paymentEnum: .cash) {
                viewModel.payment = .cash
            }
            
            PaymentSelected(icon: "paypallogo2", paymentEnum: .paypal) {
                viewModel.payment = .paypal
            }
            
            Spacer()
            
            Button{
                viewModel.pay(email: orderAdresse.email, street: orderAdresse.street, houseNumber: orderAdresse.houseNumber, firstName: orderAdresse.firstName, lastName: orderAdresse.lastName, zipCode: orderAdresse.zipCode, city: orderAdresse.city)

            }label: {
                if viewModel.loading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.white))
                }else{
                    Text(viewModel.currentView == .payment ? Strings.pay : Strings.next)
                        .font(.title2)
                        .foregroundColor(Color.theme.white)
                }
               
                  
            }  .frame(width: 300,height: 50)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.theme.greenColor))
        }.padding()
       
        .onReceive(viewModel.$error, perform: { error in
            guard let error = error else {return}
            showAlert = !error.localizedDescription.isEmpty ? true : false
        })
        .sheet(isPresented: $viewModel.paymentSuccess,onDismiss: dissmiss) {
            sucessfulPaymentView
        }
        
        .alert(viewModel.error?.localizedDescription ?? "", isPresented: $showAlert) {
            Button("OK", action: {
                showAlert = false
                viewModel.error = nil
                viewModel.loading = false
            })
        }
    }
    
   private func dissmiss(){
        viewModel.paymentSuccess = false
       viewModel.deleteCartProducts()
       action()
    }
    
    private var sucessfulPaymentView: some View{
        VStack(spacing: 20){
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .foregroundColor(Color.theme.greenColor)
                .frame(width: 100,height: 100)
                .symbolEffect(.pulse)
            
            Text("Zahlung Erfolgreich")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Vielen Dank für Ihre Bestellung")
                .font(.title3)
                .padding(.top)
            
            
            Text("Sie erhalten eine Bestätigungs-E-Mail mit einer Übersicht Ihrer Bestellung. Wenn Sie Fragen haben, kontaktieren Sie uns bitte.")
                .padding(.horizontal,36)
                .multilineTextAlignment(.leading)
                .padding(.leading)
            
            Button{
                dissmiss()
            }label: {
                Text("Zurück zur Startseite")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.theme.greenColor)
                    .cornerRadius(10)
            }.padding(.top)
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
                    .frame(width: 180,height: 48)
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
        .background(Color.theme.white)
        .cornerRadius(15)
    }
}

#Preview {
    PaymentView(action: {})
        .environmentObject(OrderViewModel(products: [], totalPrice: 0.0))
}

