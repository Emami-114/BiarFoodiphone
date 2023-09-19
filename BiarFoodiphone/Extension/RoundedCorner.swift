//
//  RectangleExtension.swift
//  BiarFoodiphone
//
//  Created by Ecc on 01/09/2023.
//

import SwiftUI

struct RectangleExtension: View {
    var body: some View {
        VStack{
            Rectangle()
                .roundedCornerView(corners: .topLeft, radius: 600)
                .frame(width: 300,height: 300)
            

        }
    }
}

struct RectangleExtension_Previews: PreviewProvider {
    static var previews: some View {
            RectangleExtension()
        
            
    }
}

extension View {
    func roundedCornerView(corners: UIRectCorner,radius: CGFloat) -> some View {
      clipShape(RoundedCorner(radius: radius,corners: corners))
        
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners : UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
