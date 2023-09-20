//
//  CategoryCell.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import SwiftUI
import Kingfisher
struct CategoryCell: View {
    let category : Category
    var body: some View {
        VStack{
            ZStack{
                KFImage(URL(string: category.imageUrl))
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .resizable()
                    .scaledToFit()

            }
            Divider()
            .padding(2)
            Text(category.name)
                .font(.caption2)
                .fontWeight(.semibold)
                .lineLimit(2)
                .padding([.bottom,.horizontal],3)
        }
        .frame(maxWidth: 130,maxHeight: 120)
        .clipped()

        .background(RoundedRectangle(cornerRadius: 10).fill(Color.theme.white))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 0.5).fill(Color.theme.subTextColor)
        }
        .cornerRadius(10)
        
    }
}

struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCell(category: .init(mainId:"",name: "Bier Category", desc: "sdcscsas", type: "Main", imageUrl: "https://firebasestorage.googleapis.com/v0/b/biarfood-77cad.appspot.com/o/category_images%2F51ED5921-110B-42B2-BE08-F7D37316FD9F?alt=media&token=3cb12b0b-c6a6-4497-ba45-ecae2c01b9b7"))
    }
}
