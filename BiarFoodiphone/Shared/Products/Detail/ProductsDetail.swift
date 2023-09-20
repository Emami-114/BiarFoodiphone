//
//  ProductsDetail.swift
//  BiarFoodiphone
//
//  Created by Ecc on 02/09/2023.
//

import SwiftUI
import Kingfisher
struct ProductsDetail: View {
    @State var seleted = ""
    let product: Product
    @State private var showAlert = false
    @Namespace var nameSpace
    @StateObject var viewModel : DetailViewModel = DetailViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            
        ScrollView(.vertical,showsIndicators: false){
            
                ZStack(alignment: .bottom){
                    KFImage(URL(string: product.imageUrl))
                        .loadDiskFileSynchronously()
                        .cacheMemoryOnly()
                        .fade(duration: 0.5)
                        .resizable()
                     
                    
                    VStack (spacing: 10){
                        HStack{
                            HStack{
                                if product.sale{
                                    let saleProcent = (product.salePrice-product.price)/product.price * 100
                                    Text("\(String(format: "%2.f", saleProcent))%")
                                        .font(.title3.bold())
                                        .foregroundColor(.white)
                                        .padding(.horizontal,13)
                                        .padding(.vertical,5)
                                        .background{
                                            HStack{
                                                Rectangle().fill(.red)
                                                    .roundedCornerView(corners: [.topLeft,.bottomRight], radius: 15)}
                                        }
                                }
                            }
                            Spacer()
                            HStack{
                                Button{
                                    if viewModel.isFavorite(id: product.id ?? ""){
                                        viewModel.favoriteDelete(with: product.id ?? "")
                                    }else {
                                        if viewModel.userIsLogged{
                                            viewModel.addUserFavorite(productId: product.id ?? "", productName: product.title)
                                        }else {
                                            showAlert = true
                                        }
                                    
                                        
                                    }
                                    
                                }label: {
                                    Image(systemName: viewModel.isFavorite(id: product.id ?? "") ? "heart.fill" : "heart")
                                        .foregroundColor(viewModel.isFavorite(id: product.id ?? "") ? .red : .black)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        
                                }.padding(.trailing,15)
                            }.offset(y: 10)
                        }
                        Spacer()
                        
                        if product.adult{
                            HStack{
                                Text("+\(product.minimumAge)")
                                    .font(.title3.bold())
                                    .padding(10)
                                    .overlay{
                                        Circle()
                                            .stroke(lineWidth: 4).fill(.red)
                                    }
                                VStack(alignment: .leading){
                                    Text("Bestellung ab \(product.minimumAge) jahren.")
                                        .font(.footnote.bold())
                                    Text("Für dieses Produkt gilt das Jugendschutzgesetz.")
                                        .font(.caption2)
                                }
                            }.padding(10)
                                .background(.ultraThinMaterial)
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 0.2)
                                })
                                .cornerRadius(15)
                                .padding(.bottom,5)
                        }
                    }
                }.frame(height: 350)
                .background(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 0.5).fill(Color.theme.iconColor))
                .cornerRadius(15)
                .clipped()
                    
            HStack(){
                Text(product.title)
                    .font(.title2)
                    .foregroundColor(Color.theme.blackColor)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .padding(.horizontal,3)
                Spacer()
            }
                HStack{
                    if !product.netFillingQuantity.isEmpty{
                        HStack(spacing: 2){
                            Text(product.netFillingQuantity)
                                .font(.body)
                                .foregroundColor(Color.theme.blackColor)

                            Text(product.unit)
                                .font(.footnote)
                                .foregroundColor(Color.theme.blackColor)
                        }.padding(.horizontal,3)
                    }
                    Spacer()
                    Text(product.depositType)
                        .font(.title3.bold())
                        .foregroundColor(Color.theme.iconColor)
                }
                HStack(alignment: .center,spacing: 0){
                    if !product.unitAmountPrice.isEmpty {
                        Text(product.unitAmountPrice)
                            .font(.footnote)
                            .foregroundColor(Color.theme.subTextColor)
                            .lineLimit(1)
                    }
                    if product.deposit {
                        Text("+zzgl.\(String(format: "%.2f", product.depositPrice))€ Pfand")
                            .font(.footnote)
                            .foregroundColor(Color.theme.subTextColor)
                            .padding(.horizontal,3)
                    }
                    Spacer()
                }.padding(.horizontal,5)
                HStack{
                    if product.sale{
                        HStack(spacing: 10){
                            Text("\(PriceReplacing(price: product.price))€")
                                .font(.title2)
                                .foregroundColor(Color.theme.iconColor)
                                .strikethrough(true,color: .red)
                            Text("\(PriceReplacing(price: product.salePrice))€")
                                .font(.title.bold())
                                .foregroundColor(Color.theme.blackColor)

                        }.padding(.horizontal,3)
                    }else{
                        Text("\(PriceReplacing(price: product.price))€")
                            .font(.title.bold())
                            .foregroundColor(Color.theme.blackColor)
                            .padding(.horizontal,3)
                    }
                    Spacer()
                }

                informationTab()
                RoundedRectangle(cornerRadius: 3)
                    .frame(height: 0.5).shadow(color: .black.opacity(0.6),radius:4,x: 0,y: 4)
                    
                switch viewModel.selectedTab{
                case "Für Dish" : productRecommend()
                case "Details" : details()
                case "Inhalts" : ingerdientAndAllergie()
                case "Kontakt" : contact()
                default:
                    Text("  ")
                }
    
            }
        }.frame(minWidth: 300,minHeight: 200)
            .padding()
            
        .background(Color.theme.backgroundColor)
        .alert(Text("Achtung"), isPresented: $showAlert, actions: {
            HStack{
                NavigationLink(destination: AuthenticationView().navigationBarBackButtonHidden(true)) {
                    Text("Anmelden")
                }
                Button(role: .cancel) {
                    showAlert = false
                } label: {
                    Text("Abbrechen")
                }

            }
        }, message: {
            Text("Bevor sie Produkten im warenkorb anlegen, müssen sie sich anmelden")
        })
        .onAppear{
            viewModel.fetchFavoriteSingle(with: product.id ?? "")
            viewModel.fetchDetailProducts(with: product.categorie.first ?? "")
        }
    }
    
    @ViewBuilder
    func ingerdientAndAllergie() -> some View {
        Text(product.ingredientsAndAlegy)
            .foregroundColor(Color.theme.blackColor)
            .padding(.bottom)
        
        VStack (alignment: .center){
            let nutriList = [
                TableModel(title: "Nährwerte",nutritionValue: product.referencePoint),
                TableModel(title: "Brennwert kj", nutritionValue: "\(product.calorificKJ ) KJ"),
                TableModel(title: "Brennwert kcal", nutritionValue: "\(product.caloricValueKcal ) Kcal"),
                TableModel(title: "Fett", nutritionValue: "\(product.fat ) g"),
                TableModel(title: "davon Fettsäure", nutritionValue: "\(product.fatFromSour ) g"),
                TableModel(title: "Kohlenhydrate", nutritionValue: "\(product.carbohydrates ) g"),
                TableModel(title: "Kohlenhydrate", nutritionValue: "\(product.CarbohydratesFromSugar ) g"),
                TableModel(title: "Kohlenhydrate", nutritionValue: "\(product.protein ) g"),
                TableModel(title: "Kohlenhydrate", nutritionValue: "\(product.salt ) g"),
            ]
            HStack{
                Table(nutriList) {
                        TableColumn("Nährwerte", value: \.title)
                }
                Table(nutriList) {
                        TableColumn("\(product.referencePoint)", value: \.nutritionValue)
                }
            }
            .padding()
        }
        .frame(height: 500)
        .border(.white.opacity(0.4))
        .cornerRadius(10)
        Text(product.additionallyWert )
            .foregroundColor(Color.theme.blackColor)
    }
    @ViewBuilder
    func contact() -> some View{
        Text(product.madeIn)
            .foregroundColor(Color.theme.blackColor)

    }
    
    @ViewBuilder
    func details() -> some View{
        Text(product.desc)
            .font(.footnote)
            .foregroundColor(Color.theme.blackColor)
    }
    
    @ViewBuilder
    func productRecommend() -> some View{
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 5), count: 3)) {
                ForEach(viewModel.products,id: \.id) { prod in
                    NavigationLink(destination: ProductsDetail(product: prod)) {
                        ProductCell(product: prod)
                    }.buttonStyle(.plain)
                }
            }
         
    }
    
    
    @ViewBuilder
    func informationTab() -> some View{
        let tabList = ["Für Dish","Details","Inhalts","Kontakt"]
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing: 30){
                ForEach(tabList,id: \.self) { tab in
                    TabBarItem(tabBarItemName: tab, nameSpace: nameSpace, currentTab: $viewModel.selectedTab, tabID: tab, fetchProduct: {})
                }
            }
        }.padding(0)
       
    }
}

struct ProductsDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProductsDetail(product:  .init(title: "Coca-Cola 2l", desc: "koffeinhaltiges Erfrischungsgetränk mit Pflanzenextrakten", price: 2, categorie: [], brand: "",sale: true, salePrice: 1.0, unit: "ml", imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/biarfood-77cad.appspot.com/o/product_images%2F9DE8DE57-7DBD-4540-AA8B-A07D486857BC?alt=media&token=8afe7471-2b46-4885-a317-330cb4d26f57", unitAmountPrice: "(1 l = 0,95 €)", tax: 0, articleNumber: "6729673", available: false, availableAmount: 0, deposit: true, depositType: "Mehrweg", depositPrice: 3.30, netFillingQuantity: "330", alcoholicContent: "", nutriScore: "", ingredientsAndAlegy: "wefwefwe we fewfw ewefwe we fwe", madeIn: "Kontaktname: Coca-Cola European Partners Deutschland GmbH Kontaktadresse: Postfach 67 01 56, 10207 Berlin", referencePoint: "", calorificKJ: "34t", caloricValueKcal: "454", fat: "5656", fatFromSour: "565", carbohydrates: "45", CarbohydratesFromSugar: "566", protein: "45", salt: "454", additionallyWert: "tzjtzn tzjtj tzjtzjtzj tzjtz",isCold: true,isPublic: true,adult: true,minimumAge: 19))
    }
}
