//
//  CategoriesListView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var viewModel : CategorieViewModel
    @EnvironmentObject var productViewModel : ProductsViewModel
    var body: some View {
        responsiveView { props in
            ScrollView(.vertical,showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 5), count: props.isIpad ? 6 : 4)) {
                    ForEach(viewModel.categories.filter({ category in
                        category.type == "Main"
                    }),id: \.id){category in
                        NavigationLink(destination:
                                ProductsView(categorieId: category.id ?? "")
                            .environmentObject(productViewModel)
                            .environmentObject(viewModel)
                        ) {
                            CategoryCell(category: category)
                                
                        }.foregroundColor(.black)
                    }
                }
                
            }
            .padding()
        }
        
    }
}

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environmentObject(CategorieViewModel())
            .environmentObject(ProductsViewModel())
    }
}
