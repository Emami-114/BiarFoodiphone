//
//  BottomBarView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 11/09/2023.
//

import SwiftUI

struct BottomBarView: View {
    @ObservedObject private var viewModel : BottomBarViewModel
    @Binding var showSiderBar: Bool
    init(showSiderBar: Binding<Bool>){
        self._showSiderBar = showSiderBar
        self.viewModel = BottomBarViewModel(showSiderBar: showSiderBar)
    }
    
    @Namespace var nameSpace
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                viewModel.view
                Spacer()
                    HStack(){
                        ForEach(BottomBar.allCases,id: \.self) { bottomBar in
                            BottomBarIcon(bottomBar: bottomBar,showSiderBar: $showSiderBar, cartCount: $viewModel.cartCounter, nameSpace: nameSpace)
                                
                                
                        }
                    }.frame(maxWidth: .infinity)
                        .background(
                            Rectangle().fill(Color.white).shadow(color: Color.black.opacity(0.15),radius: 5,x: 0,y: -4))
                        
            }.frame(maxHeight: .infinity,alignment: .bottom)
        }
        .environmentObject(viewModel)

        .onAppear{
            viewModel.fetchCartCount()
        }
    }
}


struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(showSiderBar: .constant(false))
    }
}
