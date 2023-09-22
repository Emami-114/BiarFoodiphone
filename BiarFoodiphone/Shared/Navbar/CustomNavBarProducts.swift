//
//  CustomNavBarProducts.swift
//  BiarFoodiphone
//
//  Created by Ecc on 22/09/2023.
//

import SwiftUI

struct CustomNavBarProducts: View{
    var showBackButton: Bool = true
    var showTrillingButton: Bool = true
    var title: String = "mngnmtt"
     var trillingButtonIcon: String = "cart"
    var color: Color = Color.theme.greenColor
    @Binding var cartCount : Int
    var trillingButtonAction: () -> Void
    var backButtonAction: () -> Void
    var body: some View{
            HStack{
                    backButton
                    .opacity(showBackButton ? 1 : 0)
                Spacer()
                titleSection
                Spacer()
                    trillingButton
                    .opacity(showTrillingButton ? 1 : 0)
                
            }
            .padding()
            .accentColor(Color.theme.white)
            .foregroundColor(Color.theme.white)
            .font(.headline)
            .background(color.ignoresSafeArea(edges: .top).shadow(radius: 5))
        
    }
}
extension CustomNavBarProducts {
    private var backButton: some View{
        Button{
            withAnimation(.spring){
                backButtonAction()
            }
        }label: {
            Image(systemName: "chevron.left")
        }
    }
    
    private var titleSection: some View {
        VStack(spacing: 4, content: {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
        })
    }
    
    private var trillingButton: some View{
            Button{
                withAnimation(.spring()){
                    trillingButtonAction()
                }
            }label: {
                HStack{
                    Image(systemName: trillingButtonIcon)
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
                }
                .foregroundColor(Color.theme.white)
            }
    }
}

#Preview {
    CustomNavBarProducts(cartCount: .constant(10), trillingButtonAction: {}, backButtonAction: {})
}
