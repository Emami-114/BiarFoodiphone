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
                LazyVStack(spacing: 5){
                    ForEach(viewModel.products,id: \.id){product in
                        NavigationLink(value: product) {
                            FavoriteCell(product: product) {
                                viewModel.resertFavorite()
                                viewModel.deleteFavoriteProduct(with: product.id ?? "")
                            }

                        }
                        NavigationLink(destination: ProductsDetail(product: product)) {
                        }
                    } 
                }
            }
        }
        .navigationDestination(for: Product.self) { product in
            ProductsDetail(product: product)
        }
        .onAppear{
            viewModel.fetchFavoriteProducts()

        }
    }
}

#Preview {
    FavoritsView()
}
