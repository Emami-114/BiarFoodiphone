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
            Color.theme.backgroundColor
                .ignoresSafeArea(.all,edges: .all)
                VStack{
                    CustomNavBarView(showBackButton: false,title: Strings.shoppingCart, trillingButtonAction: {}, backButtonAction: {})
                    if viewModel.cartProducts.isEmpty{
                        Spacer()
                       CartEmpty
                        Spacer()
                    }else {
                        ScrollView{
                            LazyVStack {
                                ForEach(viewModel.cartProducts,id: \.id) { product in
                                    NavigationLink(destination: ProductsDetail(product: product)) {
                                        CartItem(product: product)
                                        
                                        .environmentObject(viewModel)
                                      
                                    }
                                    .buttonStyle(.plain)
                                       
                                } 
                            }
                            TotalPriceView
                        }
                    }
                    Spacer()
                }
            }
        }
            .onAppear{
                viewModel.fetchCartProductsId()
                viewModel.fetchCartProducts()
            }
    }
    private var CartEmpty: some View{
        VStack{
            Image(systemName: "cart.badge.questionmark")
                .resizable()
                .frame(width: 180,height: 180)
            Text(Strings.shoppingCartIsEmpty)
                .font(.title)
                .fontWeight(.semibold)
        }.padding(30)
            .foregroundColor(Color.theme.iconColor)

        .frame(width: 350,height: 350)
        .background(RoundedRectangle(cornerRadius: 30).fill(.thinMaterial))
    }
    
    private var TotalPriceView: some View {
        VStack{
            if viewModel.salePrice() > 0{
                HStack{
                    Text(Strings.saved)
                    Spacer()
                    Text("-\(PriceReplacing(price: viewModel.salePrice()))€")
                }.font(.footnote.bold())
                    .foregroundColor(.red)
                    .padding(.horizontal,25)
                Divider()
            }
            if viewModel.depositPrice() > 0 {
                HStack{
                    Text(Strings.deposit)
                    Spacer()
                    Text("\(PriceReplacing(price: viewModel.depositPrice()))€")
                }.font(.footnote.bold())
                    .foregroundColor(Color.theme.subTextColor)
                    .padding(.horizontal,25)
                Divider()
            }

            HStack{
                HStack(alignment: .bottom, spacing: 5){
                    Text(Strings.totalAmount)
                        .font(.subheadline.bold())
                        .foregroundColor(Color.theme.iconColor)
                    Text(Strings.Incl_VAT)
                        .font(.caption2)
                        .foregroundColor(Color.theme.subTextColor)
                }
                Spacer()
                Text("\(PriceReplacing(price: viewModel.totalPrice()))€")
            }.font(.subheadline.bold())
            .foregroundColor(Color.theme.iconColor)
            .padding(.horizontal,25)
            
            NavigationLink(destination: OrderView(products: viewModel.ordrProducts())){
                Text(Strings.checkout)
            
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
        Group{
            CartsView()
                .environment(\.locale,Locale.init(identifier: "de"))

        }
    }
}
