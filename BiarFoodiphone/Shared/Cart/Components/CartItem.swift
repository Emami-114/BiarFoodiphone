//
//  CartItem.swift
//  BiarFoodiphone
//
//  Created by Ecc on 15/09/2023.
//

import SwiftUI
import Kingfisher
struct CartItem: View {
    let product : Product
    @EnvironmentObject var viewModel : CartViewModel
    var body: some View {
        HStack{
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
                }
            }
            VStack(alignment: .leading){
                Text(product.title)
                    .foregroundColor(Color.theme.blackColor)
                    .font(.subheadline)
                    .lineLimit(2)
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
                HStack{
                    if product.sale{
                        HStack(spacing: 3){
                            Text("\(PriceReplacing(price: product.price))€")
                                .font(.caption)
                                .foregroundColor(Color.theme.subTextColor)
                                .strikethrough(true,color: .red)
                            Text("\(PriceReplacing(price: product.salePrice))€")
                                .font(.callout.bold())
                                .foregroundColor(Color.theme.blackColor)
                            
                        }.padding(.horizontal,3)
                    }else{
                        Text("\(PriceReplacing(price: product.price))€")
                            .font(.callout.bold())
                            .foregroundColor(Color.theme.blackColor)
                            .padding(.horizontal,3)
                    }
                    Spacer()
                }
            }
            
            VStack(spacing: 5){
                Button{
                    viewModel.quantityPlus(with: product.id ?? "")
                }label: {
                    Image(systemName: "plus")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.white)
                        .padding(.top,10)

                }.frame(height: 22,alignment: .center)

                
               

                let productCount = viewModel.cartProductsId.filter { proId in
                    proId.productId == product.id ?? ""
                }.first
                
                Text(String(productCount?.quantity ?? 1))
                    .font(.footnote)
                    .fontWeight(.bold)
                    .frame(width: 25,height: 25)
                    .background(Rectangle().fill(Color.theme.white))

                Button{
                    viewModel.quantityminus(with: product.id ?? "")
                }label: {
                    Image(systemName: "minus")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.white)
                        .padding(.bottom,10)
                        
                }.frame(height: 22,alignment: .center)
                  
            }.frame(width: 25,height: 70,alignment: .center)
                
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.theme.greenColor))
                .padding(.trailing,5)
                .shadow(color: Color.theme.subTextColor.opacity(0.24),radius: 4)
        }
         
        
        .frame(maxHeight: 100)
        .background(Color.theme.white)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.3).fill(Color.theme.subTextColor)
        })
        .cornerRadius(10)
        .clipped()
        .shadow(color: Color.theme.subTextColor.opacity(0.15),radius: 5)
        .padding(.horizontal)
        
    }
}

struct CartItem_Previews: PreviewProvider {
    static var previews: some View {
        CartItem(product: .init(title: "Coca-Cola 2l Coca-Cola 2l", desc: "koffeinhaltiges Erfrischungsgetränk mit Pflanzenextrakten", price: 2, categorie: [], brand: "",sale: true, salePrice: 1.0, unit: "ml", imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/biarfood-77cad.appspot.com/o/product_images%2FFFA4DBF5-B169-4EF3-8E76-E90BD931ABFE?alt=media&token=851cf925-f7cd-45cf-b8fe-ce8dfbdd7821", unitAmountPrice: "(1 l = 0,95 €)", tax: 0, articleNumber: "6729673", available: false, availableAmount: 0, deposit: true, depositType: "", depositPrice: 3.30, netFillingQuantity: "330", alcoholicContent: "", nutriScore: "", ingredientsAndAlegy: "", madeIn: "Kontaktname: Coca-Cola European Partners Deutschland GmbH Kontaktadresse: Postfach 67 01 56, 10207 Berlin", referencePoint: "", calorificKJ: "", caloricValueKcal: "", fat: "", fatFromSour: "", carbohydrates: "", CarbohydratesFromSugar: "", protein: "", salt: "", additionallyWert: "",isCold: true,isPublic: true,adult: true,minimumAge: 19))
            .environmentObject(CartViewModel())
    }
}
