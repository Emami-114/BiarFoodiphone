//
//  NavbarView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 22/09/2023.
//

import SwiftUI

struct CustomNavBarView: View{
    var showBackButton: Bool = true
    var showTrillingButton: Bool = false
    var showSubtitle: Bool = false
    var title: String = "Title"
    var subtitle: String = "sub title"
     var trillingButtonIcon: String = "rectangle.portrait.and.arrow.right"
    var color: Color = Color.theme.greenColor
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
extension CustomNavBarView {
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
            if showSubtitle{
                Text(subtitle)
            }
        })
    }
    
    private var trillingButton: some View{
        Button{
            withAnimation(.snappy){
                trillingButtonAction()
            }
            
        }label: {
            Image(systemName: trillingButtonIcon)
        }
    }
}


#Preview {
    CustomNavBarView(showBackButton: false, trillingButtonAction: {}, backButtonAction: {})
}
