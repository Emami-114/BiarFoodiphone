//
//  OrderAdress.swift
//  BiarFoodiphone
//
//  Created by Ecc on 18/09/2023.
//

import SwiftUI

struct OrderAdress: View {
    @StateObject private var viewModel = OrderAdressViewModel()
    @State private var showAdressDetail = false
    var body: some View {
        ZStack(alignment: .top) {
            Color.theme.backgroundColor
                .ignoresSafeArea(.all,edges: .all)
            VStack {
                HStack{
                    Image(systemName: "house.and.flag.circle")
                        .resizable()
                        .font(.title)
                        .foregroundColor(Color.theme.greenColor)
                        .frame(width: 60,height: 60)
                        .padding(.trailing)
                       
                    VStack(alignment: .leading,spacing: 4){
                        HStack{
                            Text(viewModel.firstName)
                            Text(viewModel.lastName)
                        }.font(.headline)
                        HStack{
                            Text(viewModel.street)
                            Text(viewModel.houseNumber)
                        }
                        HStack{
                            Text(viewModel.zipCode)
                            Text(viewModel.city)
                        }
                        Text(viewModel.phoneNumber)
                            .font(.footnote)
                    }
                    Spacer()
                    Button{
                            showAdressDetail.toggle()
                            viewModel.oldAdresse()
                        
                    }label: {
                        Image(systemName: showAdressDetail ? "arrow.up.circle" : "arrow.down.circle")
                            .font(.title)
                            .foregroundColor(Color.theme.greenColor)
                    }
                    
                }.padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.theme.white))
            .padding()
                
                if showAdressDetail{
                    EditOrderAdresse()
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .slide))
                }
                
                Button{
                    viewModel.removeFields()
                    showAdressDetail = true

                }label: {
                    Text("Neue Adresse angeben")
                }
                
            }
        }
        .animation(.spring(response: 0.4,dampingFraction: 0.6,blendDuration: 1), value: showAdressDetail)
    }
    
    @ViewBuilder
    func EditOrderAdresse() -> some View {
        VStack{
            HStack(spacing: 5){
                TextField("Vorname", text: $viewModel.firstName2)
                    .DefaultTextFieldModifier(paddingHorizontal: 0)
                TextField("Nachname", text: $viewModel.lastName2)
                    .DefaultTextFieldModifier(paddingHorizontal: 0)
            }.padding(.horizontal)
            HStack{
                TextField("Straße", text: $viewModel.street2)
                    .DefaultTextFieldModifier(paddingHorizontal: 0)
                TextField("Straße", text: $viewModel.houseNumber2)
                    .DefaultTextFieldModifier(paddingHorizontal: 0)
            }.padding(.horizontal)
            
            HStack{
                TextField("PLZ", text: $viewModel.zipCode2)
                    .DefaultTextFieldModifier(paddingHorizontal: 0)
                TextField("Stadt", text: $viewModel.city2)
                    .DefaultTextFieldModifier(paddingHorizontal: 0)
            }.padding(.horizontal)
            TextField("Handynummer", text: $viewModel.phoneNumber2)
                .DefaultTextFieldModifier(paddingHorizontal: 15)
          
            HStack(spacing: 20){
                Button{
                    showAdressDetail = false
                }label: {
                    Text("Abbrechen")
                        .foregroundColor(Color.theme.iconColor)

                }
                .frame(width: 100,height: 40,alignment: .center)
                .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5))
                    .cornerRadius(10)
                Button{
                    viewModel.loading = true
                    DispatchQueue.main.asyncAfter(deadline: .now()+2){
                    viewModel.newAdresse()
                        viewModel.loading = false
                        showAdressDetail = false
                }
                }label: {
                    if viewModel.loading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }else{
                        Text("Speicher")
                            .foregroundColor(Color.theme.white)
                    }
                  
                }.frame(width: 100,height: 40,alignment: .center)
                    .background(Color.theme.greenColor)
                    .cornerRadius(10)
            }.padding(.horizontal)
                .padding()
            
        }.padding(.vertical)
            .background(RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 0.5).fill(Color.theme.iconColor))
            .overlay(alignment: .top,content: {
                Rectangle()
                    .trim(from: 0,to: 0.5).stroke(lineWidth: 0.5).fill(Color.theme.iconColor)
                    .frame(width: 40,height: 40)
                .rotationEffect(Angle(degrees: -45))
                .offset(y: -20)
        })
        .padding()
    }
}

struct OrderAdress_Previews: PreviewProvider {
    static var previews: some View {
        OrderAdress()
    }
}
