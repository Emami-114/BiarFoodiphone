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
    var props: Properties
    var navigationToCart: () -> Void
    var body: some View {
            ScrollView(.vertical,showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 5), count: props.isIpad ? 6 : props.isIpad && props.isLandscape ? 8 : 4)) {
                    ForEach(viewModel.categories.filter({ category in
                        category.type == "Main"
                    }),id: \.id){category in
                        NavigationLink(destination:
                                        ProductsView(props: props, navigationToCart: navigationToCart, categorieId: category.id ?? "")
                            .environmentObject(productViewModel)
                            .environmentObject(viewModel)
                        ) {
                            CategoryCell(category: category)
                                
                        }.foregroundColor(.black)
                            .navigationBarBackButtonHidden(true)
                    }
                }
                
            }
            .padding()
        
        
    }
}

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView( props: .init(isLandscape: false, isIpad: false, size: CGSize(), isCompat: true), navigationToCart: {})
            .environmentObject(CategorieViewModel())
            .environmentObject(ProductsViewModel())
    }
}
