//
//  SliderView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 30/08/2023.
//

import SwiftUI
import Kingfisher
struct SliderView: View {
    @ObservedObject var viewModel : SliderViewModel
    @Binding var selectedIndex : Int
    let props: Properties
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                TabView(selection: $selectedIndex) {
                    if let sliders = viewModel.sliders{
                        ForEach(0..<sliders.count,id: \.self){index in
                            SliderCell(slider: sliders[index])

                                    .padding(.horizontal)
                            
                        }
                    }
                }

                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))

            }.frame(width: props.isIpad ? 700 : 400,height: 280)
            
        }
    }
}

struct SliderCell: View{
    let slider: Slider
    var body: some View{
        ZStack(alignment: .bottom){
            KFImage(URL(string: slider.imageUrl))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.9)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .cornerRadius(15)
                .clipped()
            if !(slider.desc.isEmpty && slider.title.isEmpty){
                HStack{
                    VStack(alignment: .leading,spacing: 5){
                        Text(slider.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        Text(slider.desc)
                            .font(.footnote)
                            .lineLimit(2)
                    }.padding(.leading)
                    Spacer()
                }
                    .padding(5)
                    .frame(maxWidth: .infinity)
                    .background(.thinMaterial.opacity(0.95))
                    .cornerRadius(10)
            }
           
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .cornerRadius(15)
            .shadow(color: Color.theme.subTextColor.opacity(0.2),radius: 10)

    }
}


struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(viewModel: SliderViewModel(),selectedIndex: .constant(0), props: .init(isLandscape: false, isIpad: false, size: CGSize(), isCompat: true))
    }
}
