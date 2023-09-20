//
//  CartsView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 15/09/2023.
//

import SwiftUI

struct CartsView: View {
    @StateObject var viewModel : CartViewModel = CartViewModel()
    
    var body: some View {
        NavigationStack{
        ZStack{
            Color.theme.backgroundColor.ignoresSafeArea(.all,edges: .all)
        
                VStack{
                    if viewModel.cartProducts.isEmpty{
                        Spacer()
                        VStack{
                            Image(systemName: "cart.badge.questionmark")
                                .resizable()
                                .frame(width: 200,height: 200)
                                Text("Warenkorb ist leer")
                                .font(.title)
                                .fontWeight(.semibold)
                        }.padding(30)
                            .foregroundColor(Color.theme.iconColor)

                        .frame(width: 300,height: 400)
                        .background(RoundedRectangle(cornerRadius: 30).fill(.thinMaterial))
                        Spacer()
                    }else {
                        ScrollView{
                            LazyVStack {
                                ForEach(viewModel.cartProducts,id: \.id) { product in
                                    
                                    NavigationLink(destination: ProductsDetail(product: product)) {
                                        CartItem(product: product)
                                        .environmentObject(viewModel)
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true)
                                    }.buttonStyle(.plain)
                                    .navigationViewStyle(StackNavigationViewStyle())
                                    
                                        .swipeActions {
                                            Button(role: .destructive) {
                                            } label: {
                                                Label("Löschen", systemImage: "trash")
                                            }
                                        }
                                }
                               
                            }
                            TotalPriceView()
                           
                        }
                    
                    }
                }
                

            }
        }
            
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar(content: {
                ToolbarItem {
                    EditButton()
                    
                }
            })
            .onAppear{
                viewModel.fetchCartProductsId()
                viewModel.fetchCartProducts()
            }
    }
    
    @ViewBuilder
    func TotalPriceView() -> some View {
        VStack{
            if viewModel.salePrice() > 0{
                HStack{
                    Text("Gespart")
                    Spacer()
                    Text("-\(PriceReplacing(price: viewModel.salePrice()))€")
                }.font(.footnote.bold())
                    .foregroundColor(.red)
                    .padding(.horizontal,25)
                Divider()
            }
            if viewModel.depositPrice() > 0 {
                HStack{
                    Text("Pfand")
                    Spacer()
                    Text("\(PriceReplacing(price: viewModel.depositPrice()))€")
                }.font(.footnote.bold())
                    .foregroundColor(Color.theme.subTextColor)
                    .padding(.horizontal,25)
                Divider()
            }

            HStack{
                HStack(alignment: .bottom, spacing: 5){
                    Text("Gesamtbetrag")
                        .font(.subheadline.bold())
                        .foregroundColor(Color.theme.iconColor)
                    Text("(Inkl.MwSt.)")
                        .font(.caption2)
                        .foregroundColor(Color.theme.subTextColor)
                }
                Spacer()
                Text("\(PriceReplacing(price: viewModel.totalPrice()))€")
            }.font(.subheadline.bold())
            .foregroundColor(Color.theme.iconColor)
            .padding(.horizontal,25)
            
            NavigationLink(destination: OrderView()){
                Text("Zur Kasse")
            
                .font(.title3.bold())
                .foregroundColor(Color.theme.white)
                .frame(width: 300,height: 40)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.theme.greenColor))
            } .padding(.top)
                .padding(.bottom,80)
            
           

        }.padding(.top)
        
        
    }
    
}

struct CartsView_Previews: PreviewProvider {
    static var previews: some View {
        CartsView()

    }
}
