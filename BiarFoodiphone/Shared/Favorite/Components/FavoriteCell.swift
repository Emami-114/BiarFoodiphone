//
//  FavoriteCell.swift
//  BiarFoodiphone
//
//  Created by Ecc on 21/09/2023.
//

import SwiftUI
import Kingfisher
struct FavoriteCell: View {
    let product : Product
    var action: () -> Void
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
            Button{
                action()
            }label: {
                Image(systemName: "trash")
            }.foregroundColor(.red)
                .padding(.trailing,10)
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

#Preview {
    FavoriteCell(product: productExample, action: {})
}
