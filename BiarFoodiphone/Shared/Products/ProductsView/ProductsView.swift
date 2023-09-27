//
//  ProductsView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject var viewModel : ProductsViewModel
    @EnvironmentObject var categoryViewModel : CategorieViewModel
    var props: Properties
    var navigationToCart: () -> Void
    @Environment(\.dismiss) var dismiss
     var categorieId : String
    var body: some View {
        NavigationStack {
                VStack(spacing: 0){
                    CustomNavBarProducts(title: Strings.products,cartCount: $viewModel.productOnCart, trillingButtonAction: {
                        dismiss()
                        navigationToCart()
                    }, backButtonAction: {
                        dismiss()
                    })
                    ProductTabView()
                        .environmentObject(viewModel)
                        .environmentObject(categoryViewModel)
              ScrollViewReader { proxy in
              ScrollView(.vertical,showsIndicators: false) {
                  
                  LazyVStack {
                      ForEach(categoryViewModel.filterSubCategories(selectedMain: viewModel.selectedCategorie),id: \.id){subCategory in
                          Text(subCategory.name)
                              .font(.title3.bold())
                              .foregroundColor(Color.theme.iconColor)
                              .padding(10)
                              .padding(.leading,10)
                              .frame(maxWidth: .infinity,alignment: .leading)
                              .background(Color.theme.white)
                              .cornerRadius(10)
                              .padding(.vertical,10)
                              .id(subCategory.id ?? "")
                             
                          LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 7), count: props.isIpad && !props.isLandscape ? 4 : props.isIpad && props.isLandscape ? 6 : 3)) {
                                  
                                  ForEach(viewModel.productesFilter(subCategorie: subCategory.id ?? ""),id: \.id){products in
                                      
                                      NavigationLink(destination: ProductsDetail(product: products)) {
                                          ProductCell(product: products)
                                      }.buttonStyle(.plain)
                                          
                                         
                                  }
                          }
                      }
                      .onChange(of: viewModel.selectedSubCategorie) { newValue in
                          withAnimation(.default) {
                              proxy.scrollTo(newValue,anchor: .top)
                          }
                  }
                  }
                 
              }
              }.padding()
              
                }
                
            
            .ignoresSafeArea(edges: .bottom)
            .onAppear{
                viewModel.selectedCategorie = categorieId

                viewModel.fetchProducts()
            }
        }
        .navigationBarBackButtonHidden(true)

    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(props: .init(isLandscape: false, isIpad: false, size: CGSize(), isCompat: true), navigationToCart: {}, categorieId: "")
            .environmentObject(CategorieViewModel())
            .environmentObject(ProductsViewModel())
    }
}
