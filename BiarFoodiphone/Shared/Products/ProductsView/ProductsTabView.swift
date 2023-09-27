//
//  ProductsTabView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 01/09/2023.
//

import SwiftUI

//struct ProductsTabView: View {
//    @EnvironmentObject var productViewModel : ProductsViewModel
//    @EnvironmentObject var categoriesViewModel : CategorieViewModel
//    let categorieId : String
//
//    var body: some View {
//        let mainCategories = categoriesViewModel.categories.filter { category in
//            category.type == "Main"
//        }
//        TabView(selection: $productViewModel.selectedCategorie) {
//            ForEach(mainCategories,id: \.id) { category in
//                ProductsView(navigationToCart: {}, categorieId: categorieId).tag(category.id ?? "")
//                   
//            }
//        }.tabViewStyle(.page)
//            .onAppear{
//                    productViewModel.selectedCategorie = categorieId
//                    productViewModel.fetchProducts()
//            }
//    }
//}
//
//struct ProductsTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductsTabView(categorieId: "")
//            .environmentObject(CategorieViewModel())
//            .environmentObject(ProductsViewModel())
//    }
//}
