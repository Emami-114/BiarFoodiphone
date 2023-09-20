//
//  HomeView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 29/08/2023.
//

import SwiftUI

struct HomeView: View {
    @Binding var sidbarShowing: Bool
    @StateObject var sliderViewModel = SliderViewModel()
    @StateObject var categoriesViewModel = CategorieViewModel()
    @StateObject var productsViewModel = ProductsViewModel()
    @State var selectedIndex = 0
    let time = Timer.publish(every: 5, on: .main, in: .default).autoconnect()

    
    var body: some View {
            
        NavigationStack{
            responsiveView { props in
                ZStack{
                    Color.theme.backgroundColor
                        .ignoresSafeArea(.all,edges: .all)

                    VStack{
                        SliderView(viewModel: sliderViewModel,selectedIndex: $selectedIndex)
                            .onReceive(time, perform: { _ in
                                withAnimation(.default){
                                    self.selectedIndex = selectedIndex == sliderViewModel.sliders?.count ?? 0 ? 0 : selectedIndex + 1
                                }
                                
                            })

                        CategoriesView()
                            .environmentObject(categoriesViewModel)
                            .environmentObject(productsViewModel)
                        Spacer()
                    }
                }
            }
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(sidbarShowing: .constant(false))
    }
}
