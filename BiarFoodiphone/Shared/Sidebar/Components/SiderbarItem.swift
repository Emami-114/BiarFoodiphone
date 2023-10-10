//
//  SliderItem.swift
//  BiarFoodiphone
//
//  Created by Ecc on 14/09/2023.
//

import SwiftUI

struct SiderbarItem: View {
    let icon: String
    let title: String
    var body: some View {
        HStack{
            Image(systemName: icon)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color.theme.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 22,height: 22)
            Text(title)
                .font(.title3)
                .foregroundColor(Color.theme.white)
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct SiderbarItemForIpad: View {
   @Binding var currentItem: String
    let title: String
    let icon: String
    @Binding var showSidbar : Bool
    @Binding var siderbarOpen : Bool
    var nameSpace: Namespace.ID
    var body: some View {
        VStack {
           
                Button{
                    withAnimation(.spring()){
                        currentItem = self.title
                    }
                  
                }label: {
                    if siderbarOpen{
                        HStack{
                        Image(systemName: icon)
                            .resizable()
                          
                            .frame(width: 22,height: 22)
                        Text(title)
                            .font(.title3)
                            
                            .fontWeight(.semibold)
                            Spacer()

                    }
                    }else {
                        VStack(alignment: .center){
                            Image(systemName: icon)
                                .resizable()
                                .frame(width: 22,height: 22)
//                            Text(title)
//                                .font(.body)
                        }
                    }
             
                
            }
            .foregroundColor(currentItem == title ? Color.theme.white : Color.theme.blackColor)
            .padding()
            .frame(minWidth: 80,minHeight: 60)
            .background{
                if currentItem == title {
                    Rectangle().fill(Color.theme.greenColor).roundedCornerView(corners: [.topLeft,.bottomLeft,.bottomRight,.topRight], radius: 20)
                       
                        .matchedGeometryEffect(id: "SIDERBARIPDA", in: nameSpace)
                }else {
                    RoundedRectangle(cornerRadius: siderbarOpen ? 20 : 5).fill(Color.clear)
                }
            }
            .padding(.vertical)
            .padding(.horizontal)
            
            .animation(.spring(), value: currentItem)

        }
    }
    
  
    
}
#Preview(body: {
    SiderbarItemForIpad(currentItem: .constant("Home"), title: "Home",icon: "house", showSidbar: .constant(false), siderbarOpen: .constant(false), nameSpace: Namespace().wrappedValue)
    
   
})
