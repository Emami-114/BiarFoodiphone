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
    @State private var scrollID: Int? = nil
    var props: Properties
    var navigationToCart: () -> Void
    @Environment(\.dismiss) var dismiss
     var categorieId : String
    var body: some View {
        NavigationStack {
                VStack(spacing: 0){
                    let subCat = categoryViewModel.filterSubCategories(selectedMain: viewModel.selectedCategorie)

                    CustomNavBarProducts(showTrillingButton: props.isIpad ? false : true, title: "",cartCount: $viewModel.productOnCart, trillingButtonAction: {
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
                        ForEach(subCat.indices,id: \.self){index in
                              Text(subCat[index].name)
                                  .font(.title3.bold())
                                  .foregroundColor(Color.theme.iconColor)
                                  .padding(10)
                                  .padding(.leading,10)
                                  .frame(maxWidth: .infinity,alignment: .leading)
                                  .background(Color.theme.white)
                                  .cornerRadius(10)
                                  .padding(.vertical,10)
                                  .id(subCat[index].id ?? "")
                                 
                          LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 7), count: props.isIpad && !props.isLandscape ? 4 : props.isIpad && props.isLandscape ? 6 : 3)) {
                              
                              ForEach(viewModel.productesFilter(subCategorie: subCat[index].id ?? ""),id: \.id){product in
                                  
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
              }
                  .scrollPosition(id: $scrollID,anchor: .top)
                  .onChange(of: scrollID) { oldValue, newValue in
                      withAnimation(.easeInOut(duration: 0.5)) {
                          viewModel.selectedSubCategorie = subCat[newValue ?? 0].id ?? ""
                        }
              }
                  .onChange(of:viewModel.selectedSubCategorie) { oldValue,newValue in
                      withAnimation(.easeInOut(duration: 0.5)) {
                          proxy.scrollTo(newValue,anchor: .top)
                      }
              }
                 
              }.padding()
                    
                }
//                .overlay(content: {
//                                if viewModel.startAnimation{
//                                    if let selectedProduct = viewModel.selectedProduct {
//                                        withAnimation(.easeInOut(duration: 0.3)){
//                                            ProductCell(product: selectedProduct, action: {})
//                                                .frame(width: 100, height: 100)
////                                                .scaleEffect(CGSize(width: 0.5, height: 0.5))
//                                                .symbolEffect(.bounce, options: .repeat(4).speed(5), value: viewModel.startAnimation)
//  
//  
//  
//                                                .offset(y: -300)
//                                        }
//                                    }
//                                }
//                })
                .animation(.easeInOut(duration: 1), value: viewModel.startAnimation)
            
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
