//
//  SearchView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 22/09/2023.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @StateObject private var viewModel = SearchViewModel()
    let props: Properties
    var navigationToCart: () -> Void
    var body: some View {
        NavigationStack {
            VStack{
                CustomNavBarView(showBackButton: false,title: "Suchen", trillingButtonAction: {}, backButtonAction: {})
                ScrollView(.vertical,showsIndicators: false) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 5), count: props.isIpad ? 6 : props.isIpad && props.isLandscape ? 8 : 4)) {
                        ForEach(viewModel.categories,id: \.id){category in
                            NavigationLink(destination:
                                            ProductsView(props: props, navigationToCart: navigationToCart, categorieId: category.id ?? "")
                            ) {
                                CategoryCell(category: category)
                                    
                            }.foregroundColor(.black)
                                .navigationBarBackButtonHidden(true)
                        }
                    }
                }
                .padding()
                
                Spacer()

            }

        }
    }
}

#Preview {
    SearchView(props: .init(isLandscape: false, isIpad: false, size: CGSize(), isCompat: true), navigationToCart: {})
}
