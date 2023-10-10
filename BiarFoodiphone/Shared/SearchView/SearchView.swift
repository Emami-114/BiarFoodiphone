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
    @State private var searchFocusStat = false
    let props: Properties
    var navigationToCart: () -> Void
    var body: some View {
        NavigationStack {
                VStack{
                    CustomNavBarView(showBackButton: false,title: "Suchen", trillingButtonAction: {}, backButtonAction: {})
                        SearchFieldView(searchQuery: $searchText, searchFocusState: $searchFocusStat, action: {
                            Task{
                                searchText = ""
                                searchFocusStat = false
                                viewModel.searchProducts = []

                            }
                        }).padding(.vertical)
                    
                    if searchFocusStat && !searchText.isEmpty {
                        searchView
//
                    }else {
                   
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
        .onChange(of: searchText) { oldValue, newValue in
            Task{
                try await viewModel.fetchSearchProducts(query: newValue)
            }
            
        }
        .onAppear{
            viewModel.fetchCategories()
        }
//        .animation(.spring(response: 0.7,dampingFraction: 0.8,blendDuration: 1),value: searchFocusStat)
    }
    private var searchView: some View {
        VStack{
//            SearchFieldView(searchQuery: $searchText, searchFocusState: $searchFocusStat, action: {
//                Task{
//                    searchText = ""
//                    viewModel.searchProducts = []
//                    searchFocusStat = false
//      
//
//                }
//          
//            })
            ScrollView {
                LazyVStack(content: {
                    ForEach(viewModel.searchProducts, id: \.id) { product in
                        SearchItemView(product: product, action: {})
                    }
                })
            }
            
        }
    }
}

#Preview {
    SearchView(props: .init(isLandscape: false, isIpad: false, size: CGSize(), isCompat: true), navigationToCart: {})
}
