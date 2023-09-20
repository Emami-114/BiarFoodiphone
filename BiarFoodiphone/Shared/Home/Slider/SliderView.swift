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
    let time = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
    @Binding var selectedIndex : Int
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                TabView(selection: $selectedIndex) {
                    if let sliders = viewModel.sliders{
                        ForEach(0..<sliders.count,id: \.self){index in
                        GeometryReader { proxy in
                            SliderCell(slider: sliders[index])
                                    .rotation3DEffect(
                                        Angle(degrees: getPercentag(geo: proxy) * 20)
                                        , axis: (x: 1.0, y: 5.0, z: 1.0))
                                    .padding(.horizontal)
                                    .padding(.top,7)
                            }
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))

            }
            
            .frame(width: 380,height: 280)
            .padding(5)
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
                .scaledToFill()
                .frame(maxWidth: 380,maxHeight: 230)
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
           
        }.frame(maxWidth: 380,maxHeight: 230)
            .cornerRadius(15)
            .shadow(color: Color.theme.subTextColor.opacity(0.2),radius: 10)

    }
}


struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(viewModel: SliderViewModel(),selectedIndex: .constant(0))
    }
}
