//
//  DeliveryTime.swift
//  BiarFoodiphone
//
//  Created by Ecc on 18/09/2023.
//

import SwiftUI

struct DeliveryTime: View {
    @EnvironmentObject var viewModel : OrderViewModel
    var body: some View {
        VStack{
            Button{
                
            }label: {
                HStack{
                    Text("Sofort(innerhalb von 120 min)")
                    Spacer()
                    Image(systemName: "checkmark.circle")
                }
            }.buttonStyle(.plain)
                .padding(.horizontal)
                .frame(width: 300,height: 50)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.theme.white))
                .background(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 0.5))
            
            VStack(spacing: 20){
                DatePicker("Liferzeit", selection: $viewModel.deliveryTime,displayedComponents: .date)
                DatePicker("Zwischen", selection: $viewModel.deliveryTime,displayedComponents: .hourAndMinute)
            }.padding()
                
                .frame(height: 100)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.theme.white))
                
                .background(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 0.5))
                .padding(40)
                
           
        }
    }
}

struct DeliveryTime_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryTime()
            .environmentObject(OrderViewModel(products: []))
    }
}
