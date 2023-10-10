//
//  ProductsView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject var viewModel : ProductsViewModel
    @State private var scrollID: String?
    var props: Properties
    var navigationToCart: () -> Void
    @Environment(\.dismiss) var dismiss
     var categorieId : String
    var body: some View {
//        NavigationStack {
                VStack(spacing: 0){
                    CustomNavBarProducts(showTrillingButton: props.isIpad ? false : true, title: "",cartCount: $viewModel.productOnCart, trillingButtonAction: {
                        dismiss()
                        navigationToCart()
                    }, backButtonAction: {
                        dismiss()
                    })
                    ProductTabView(action: {subCatId in
                        withAnimation(.spring()){
                            scrollID = subCatId
                        }
                    })
                        .environmentObject(viewModel)
                        
                    ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(viewModel.subCategories.indices,id: \.self){index in
                            Text(viewModel.subCategories[index].name)
                                  .font(.title3.bold())
                                  .foregroundColor(Color.theme.iconColor)
                                  .padding(10)
                                  .padding(.leading,10)
                                  .frame(maxWidth: .infinity,alignment: .leading)
                                  .background(Color.theme.white)
                                  .cornerRadius(10)
                                  .padding(.vertical,10)
                                  .id(viewModel.subCategories[index].id ?? "")
                                 
                          LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 7), count: props.isIpad && !props.isLandscape ? 4 : props.isIpad && props.isLandscape ? 6 : 3)) {
                              
                              ForEach(viewModel.productesFilter(subCategorie: viewModel.subCategories[index].id ?? ""),id: \.id){product in
                                  
                                  NavigationLink(destination: ProductsDetail(product: product)) {
                                      ProductCell(product: product,action: {
                                          viewModel.startAnimation.toggle()
                                          viewModel.selectedProduct = product
                                      })
                                      
                                  }.buttonStyle(.plain)
                                  
                              }

                          }
                  }
                    }
                      
                 
                    .scrollTargetLayout()

                  }.padding()
                        .scrollPosition(id: $scrollID, anchor: .top)
                        
                  .onChange(of: scrollID ?? "") { oldValue, newValue in
                      withAnimation(.easeInOut(duration: 0.5)) {
                          viewModel.selectedSubCategorie = newValue
                        }
              }
                  
                }
            
            .ignoresSafeArea(edges: .bottom)
            .onAppear{
                viewModel.selectedCategorie = categorieId
                viewModel.fetchProducts()
                viewModel.filterSubCategories()
            }
        .navigationBarBackButtonHidden(true)
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
            ProductsView(props: .init(isLandscape: false, isIpad: false, size: CGSize(), isCompat: true), navigationToCart: {}, categorieId: "")
                .environmentObject(ProductsViewModel())
        
      
    }
}
