//
//  BottomBarIcon.swift
//  BiarFoodiphone
//
//  Created by Ecc on 11/09/2023.
//

import SwiftUI

struct BottomBarIcon: View {
    let bottomBar: BottomBar
    @Binding var showSiderBar : Bool
    @Binding var cartCount : Int
    @EnvironmentObject var viewModel: BottomBarViewModel
    var nameSpace: Namespace.ID
    var body: some View {
        Button{
            withAnimation(.default){
                viewModel.currentItem = bottomBar
                        if bottomBar == .account {
                            self.showSiderBar = true
                        }
            }
        }label: {
            HStack{
                if bottomBar == .cart{
                    if bottomBar == viewModel.currentItem{
                        Text(bottomBar.title)
                    }
                    Image(systemName: "cart")
                        .overlay(alignment: .topTrailing) {
                            if cartCount > 0 {
                                Text(String(cartCount))
                                    .padding(3)
                                    .font(.caption2)
                                    .foregroundColor(Color.theme.white)
                                    .background(Circle().fill(.red))
                                    .offset(x: 5,y: -9)
                            }
                         
                        }
                   
                }else {
                    Image(systemName: bottomBar.icon)
                    if bottomBar == viewModel.currentItem{
                        Text(bottomBar.title)
                    }
                }

            }
            .foregroundColor(bottomBar == viewModel.currentItem ? .white : .black)
                .padding()
                .frame(height: 55)
                .background{
                    if bottomBar == viewModel.currentItem{
                        Rectangle().fill(bottomBar == viewModel.currentItem ? Color.theme.greenColor : .clear)
                            .roundedCornerView(corners: [.topLeft,.topRight], radius: 20)
                            .matchedGeometryEffect(id: "bottomBar", in: nameSpace)
                            .shadow(radius: 3)
                    }
                }
                .offset(y: -5)
        }
        .animation(.spring(), value: self.bottomBar)

    }
}

struct BottomBarIcon_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarIcon(bottomBar: .home,showSiderBar: .constant(false), cartCount: .constant(1),nameSpace: Namespace().wrappedValue)
            .environmentObject(BottomBarViewModel(showSiderBar: .constant(false)))
    }
}
