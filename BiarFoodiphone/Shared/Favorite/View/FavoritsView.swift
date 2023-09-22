//
//  FavoritsView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 21/09/2023.
//

import SwiftUI

struct FavoritsView: View {
    @StateObject private var viewModel = FavoriteViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 20){
            CustomNavBarView(showBackButton: false, title: Strings.favoritSeit,trillingButtonAction: {}, backButtonAction: {})
            
            ScrollView {
                LazyVStack{
                    ForEach(viewModel.products,id: \.id){product in
                        NavigationLink(destination: ProductsDetail(product: product)) {
                            FavoriteCell(product: product)
                        }
                       
                    } 
                    .onDelete(perform: { indexSet in
                        viewModel.deleteFavoriteProduct(at: indexSet)
                    })
                }
            }
           
        }
       
        .onAppear{
            viewModel.fetchFavoriteProducts()
        }
    }
}

#Preview {
    FavoritsView()
}
