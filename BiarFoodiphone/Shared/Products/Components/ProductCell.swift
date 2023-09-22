//
//  ProductCell.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import SwiftUI
import Kingfisher
struct ProductCell: View {
    let product: Product
    @StateObject private var viewModel = ProductCellViewModel()
    @State var loading = false
    @State var isFavorite = true
    @State var showAlert = false
    var body: some View {
        VStack(alignment: .leading,spacing: 3){
            ZStack(alignment: .bottom){
                KFImage(URL(string: product.imageUrl))
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.5)
                    .resizable()
                    .scaledToFit()
                    .padding(2)
                VStack{
                    HStack{
                        if product.sale{
                            let saleProcent = (product.salePrice-product.price)/product.price * 100
                            Text("\(String(format: "%2.f", saleProcent))%")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .padding(.horizontal,6)
                                .background{
                                    HStack{
                                        Rectangle().fill(.red)
                                            .roundedCornerView(corners: [.topLeft,.bottomRight], radius: 10)
                                    }
                                    
                                }
                        }
                        Spacer()
                    }
                    Spacer()
                    if product.isCold{
                        HStack{
                            Spacer()
                            Image(systemName: "thermometer.snowflake")
                                .foregroundColor(.white)
                                .font(.footnote)
                                .padding(3)
                                .background(Rectangle().fill(Color.theme.greenColor).roundedCornerView(corners: [.topLeft,.bottomLeft], radius: 5))
                             }
                    }
                    
                    Divider()
                }
            }
            
            
            ZStack(alignment: .bottomLeading){
                VStack(alignment: .leading){
                    Text(product.title)
                        .foregroundColor(Color.theme.blackColor)
                        .font(.footnote)
                        .lineLimit(1)
                        .padding(.horizontal,3)
                    if !product.netFillingQuantity.isEmpty{
                        HStack(spacing: 2){
                            Text(product.netFillingQuantity)
                                .font(.caption2)
                                .foregroundColor(Color.theme.blackColor.opacity(0.8))
                            Text(product.unit)
                                .font(.caption2)
                                .foregroundColor(Color.theme.blackColor.opacity(0.8))
                        }.padding(.horizontal,3)
                    }
                    HStack(alignment: .center,spacing: 0){
                        if !product.unitAmountPrice.isEmpty {
                            Text(product.unitAmountPrice)
                                .font(.system(size: 9))
                                .foregroundColor(Color.theme.subTextColor)
                                .lineLimit(1)
                        }
                    }.padding(.horizontal,3)
                    if product.deposit {
                        Text("zzgl.\(String(format: "%.2f", product.depositPrice))€ \(Strings.deposit)")
                            .font(.system(size: 8))
                            .foregroundColor(Color.theme.subTextColor)
                            .padding(.horizontal,3)
                    }
                    HStack{
                        if product.sale{
                            HStack(spacing: 3){
                                Text("\(PriceReplacing(price: product.price))€")
                                    .font(.system(size: 8))
                                    .foregroundColor(Color.theme.subTextColor)
                                    .strikethrough(true,color: .red)
                                Text("\(PriceReplacing(price: product.salePrice))€")
                                    .font(.caption2.bold())
                                    .foregroundColor(Color.theme.blackColor)
                                
                            }.padding(.horizontal,3)
                        }else{
                            Text("\(PriceReplacing(price: product.price))€")
                                .font(.footnote.bold())
                                .foregroundColor(Color.theme.blackColor)
                                .padding(.horizontal,3)
                        }
                    } .padding(.bottom,5)

                    
                }
                
                HStack{
                    Spacer()
                    if viewModel.isProductOnCart(productId: product.id ?? ""){
                        VStack(spacing: 5){
                            Button{
                                viewModel.quantityPlus(with: product.id ?? "")
                            }label: {
                                Image(systemName: "plus")
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.theme.white)
                                    .padding(.top,10)

                            }.frame(height: 20,alignment: .center)

                           
                            let productCount = viewModel.cartProductId.filter { proId in
                                proId.productId == product.id ?? ""
                           }.first
                            
                            Text(String(productCount?.quantity ?? 1))
                                .font(.footnote)
                                .fontWeight(.bold)
                                .frame(width: 20,height: 20)
                                .background(Rectangle().fill(Color.theme.white))

                            Button{
                                viewModel.quantityminus(with: product.id ?? "")
                            }label: {
                                Image(systemName: "minus")
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.theme.white)
                                    .padding(.bottom,10)
                                    
                            }.frame(height: 20,alignment: .center)
                              
                        }.frame(width: 20,height: 60,alignment: .center)
                            
                            .background(Rectangle().fill(Color.theme.greenColor).roundedCornerView(corners: [.topLeft,.bottomRight], radius: 4))
                            .shadow(color: Color.theme.subTextColor.opacity(0.24),radius: 4)
                    }else{
                        Button{
                            if viewModel.userIsLogged{
                                viewModel.addCartProductId(with: product.id ?? "")
                            }else {
                                showAlert = true
                            }
                            
                            
                        }label: {
                            if viewModel.loading{
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .foregroundColor(.white)
                                    .frame(width: 30,height: 30)

                            }else{
                                Image(systemName: "plus.circle")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(width: 30,height: 30)
                            }
                                
                        }
                        .background(Rectangle().fill(Color.theme.greenColor).roundedCornerView(corners: [.topLeft,.bottomRight], radius: 10))
                    }
                    
                }
                
            }
        }
        .frame(minWidth: 115,minHeight: 140)
        .background(Color.theme.white)
        .overlay(content: {
            if viewModel.isProductOnCart(productId: product.id ?? ""){
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3).fill(Color.theme.greenBlack)
            }else {
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.3).fill(Color.theme.subTextColor)
            }
            
        })
        .cornerRadius(10)
        .clipped()
        .shadow(color: Color.theme.subTextColor.opacity(0.15),radius: 5)

        .alert(Text(Strings.youAreNotLoggedIn), isPresented: $showAlert, actions: {
            HStack{
                NavigationLink(destination: AuthenticationView().navigationBarBackButtonHidden(true)) {
                    Text(Strings.login)
                }
                Button(role: .cancel) {
                    showAlert = false
                } label: {
                    Text(Strings.cancel)
                }

            }
        }, message: {
            Text(Strings.YouMustLogInBeforeAddingProductsToTheShoppingCart)
        })
        .onAppear{
            viewModel.fetchCartProductsId()
        }
        .animation(.spring(), value: viewModel.isProductOnCart(productId: product.id ?? ""))
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: .init(title: "Coca-Cola 2l", desc: "koffeinhaltiges Erfrischungsgetränk mit Pflanzenextrakten", price: 2, categorie: [], brand: "",sale: true, salePrice: 1.0, unit: "ml", imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/biarfood-77cad.appspot.com/o/product_images%2F9DE8DE57-7DBD-4540-AA8B-A07D486857BC?alt=media&token=8afe7471-2b46-4885-a317-330cb4d26f57", unitAmountPrice: "(1 l = 0,95 €)", tax: 0, articleNumber: "6729673", available: false, availableAmount: 0, deposit: true, depositType: "", depositPrice: 3.30, netFillingQuantity: "330", alcoholicContent: "", nutriScore: "", ingredientsAndAlegy: "", madeIn: "Kontaktname: Coca-Cola European Partners Deutschland GmbH Kontaktadresse: Postfach 67 01 56, 10207 Berlin", referencePoint: "", calorificKJ: "", caloricValueKcal: "", fat: "", fatFromSour: "", carbohydrates: "", CarbohydratesFromSugar: "", protein: "", salt: "", additionallyWert: "",isCold: true,isPublic: true,adult: true,minimumAge: 19))
            .frame(width: 110,height: 180)
    }
}
