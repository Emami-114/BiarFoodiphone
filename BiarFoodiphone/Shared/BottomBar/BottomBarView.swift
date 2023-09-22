//
//  BottomBarView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 11/09/2023.
//

import SwiftUI

struct BottomBarView: View {
    @StateObject private var viewModel : BottomBarViewModel = BottomBarViewModel()
    var props: Properties
    @Binding var showSiderBar: Bool
    @Namespace var nameSpace
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack{
                        switch viewModel.currentItem {
                        case .home:
                            AnyView(HomeView(sidbarShowing: $showSiderBar, props: props, naviagtionToCart: {viewModel.currentItem = .cart}))
                        case .search:
                            AnyView(SearchView())
                        case .cart:
                            AnyView(CartsView())
                        case .favorite:
                            AnyView(FavoritsView())
                        }
                    Spacer()
                        HStack(){
                            BottomBarIcon(icon: BottomBar.home.icon, title: BottomBar.home.title, action: {
                        
                                viewModel.buttonBarChange(bottomBar: .home)
                            }, cartCount: $viewModel.cartCounter, nameSpace: nameSpace)
                            BottomBarIcon(icon: BottomBar.search.icon, title: BottomBar.search.title, action: {
                                viewModel.buttonBarChange(bottomBar: .search)
                            }, cartCount: $viewModel.cartCounter, nameSpace: nameSpace)
                            BottomBarIconWithCounter(icon: BottomBar.cart.icon, title: BottomBar.cart.title, action: {
                                viewModel.buttonBarChange(bottomBar: .cart)

                            }, cartCount: $viewModel.cartCounter, nameSpace: nameSpace)
                            
                            BottomBarIconWithCounter(icon: BottomBar.favorite.icon, title: BottomBar.favorite.title, action: {
                                viewModel.buttonBarChange(bottomBar: .favorite)
                            }, cartCount: $viewModel.favoritsCounter, nameSpace: nameSpace)
//
                            BottomBarIcon(icon: "person.fill", title: "Konto", action: {
                                showSiderBar = true
                            }, cartCount: $viewModel.cartCounter, nameSpace: nameSpace)
                        }.frame(maxWidth: .infinity)
                            .background(
                                Rectangle().fill(Color.white).ignoresSafeArea(edges: .bottom))
                            .shadow(color: Color.black.opacity(0.2),radius: 5,x: 0,y: -4)
                }
                        
            }.frame(maxHeight: .infinity,alignment: .bottom)
        }
        .environmentObject(viewModel)

        .onAppear{
            viewModel.fetchCartCount()
            viewModel.fetchFavoritsCount()
        }
    }
    
    
}


struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(props: .init(isLandscape: false, isIpad: false, size: CGSize(width: 400, height: 800), isIphone: false), showSiderBar: .constant(false))
    }
}


