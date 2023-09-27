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
    var nameSpace: Namespace.ID
    var body: some View {
        VStack {
            HStack{
                Button{
                    withAnimation(.spring()){
                        currentItem = self.title
                    }
                  
                }label: {
                    Image(systemName: icon)
                        .resizable()
                      
                        .frame(width: 22,height: 22)
                    Text(title)
                        .font(.title3)
                        
                        .fontWeight(.semibold)
                }
                
                Spacer()
            }
            .foregroundColor(currentItem == title ? Color.theme.white : Color.theme.blackColor)
            .padding()
            .background{
                if currentItem == title {
                    Rectangle().fill(Color.theme.greenColor).roundedCornerView(corners: [.topLeft,.bottomLeft,.bottomRight,.topRight], radius: 20)
                       
                        .matchedGeometryEffect(id: "SIDERBARIPDA", in: nameSpace)
                }else {
                    RoundedRectangle(cornerRadius: 20).fill(Color.clear)
                }
            }
            .padding(.vertical)
            .padding(.horizontal)
            
            .animation(.spring(), value: currentItem)
//            .padding(.horizontal,30)
//            .overlay(alignment: .trailing) {
//                VStack(spacing: 0){
//                    ArcSample()
//                        .stroke(lineWidth: 10).fill(Color.theme.greenColor)
//                        .frame(width: 100,height: 100)
//                        
//                        .rotationEffect(Angle(degrees: -10))
//                        .offset(x: 0,y: -40)
//    
//                }
//              
//        }
         

        }
    }
    
  
    
}



struct ArcSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 60),
                clockwise: false)
        }
    }
}
#Preview(body: {
    SiderbarItemForIpad(currentItem: .constant("ztgvuzbu hbhbjn ihbibi  iuni"), title: "ztgvuzbu hbhbjn ihbibi  iuni",icon: "", showSidbar: .constant(false), nameSpace: Namespace().wrappedValue)
    
   
})
