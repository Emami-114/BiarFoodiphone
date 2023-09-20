//
//  SidebarView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 29/08/2023.
//

import SwiftUI

struct SidebarView: View {
    @State var currentTab : String = ""
    @EnvironmentObject var viewModel : SidbarViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Namespace var animation
    @Binding var isShowing: Bool
   
    var body: some View{
        VStack(alignment: .leading,spacing: 10){
            headerSidbarView()
            LazyVStack(alignment: .leading){
                ForEach(EnumSidbarMenu.allCases,id: \.self) { tab in
                    SiderbarItem(icon: viewModel.switchItemIcon(item: tab),
                                 title: viewModel.switchItemTitle(item: tab))
                    
                    .padding(.vertical,13)
                    .frame(width: 200)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.6)){
                            viewModel.currentItem = tab
                            isShowing = false
                        }
                    }
                    
                }
            }
           
            
            HStack{
                Button{
                    userViewModel.logOut()
                }label:{
                    Label("Abmelden", systemImage: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(Color.theme.white)
                        .font(.title3.bold())
                }.padding(.horizontal)
                Spacer()
            }
            
            .frame(width: 200)

            
            Spacer()

        }.navigationBarBackButtonHidden(true)
        
        .padding(.vertical,30)
        .frame(maxWidth: .infinity)
        .background{
            Color.theme.linearGradient.ignoresSafeArea(.all,edges: .all)

        }
    }
    @ViewBuilder
    func headerSidbarView() -> some View{
                    HStack{
                        Image("IconImage")
                            .resizable()
                            .clipShape(Circle())
                            .padding(5)
                            .overlay(content: {
                                Circle()
                                    .stroke(lineWidth: 8).fill(Color.theme.white)
                                    .clipShape(Circle()).shadow(radius: 4)
                            })
                            .frame(width: 80,height: 80)
                            .clipShape(Circle())

                        Spacer()
                        Button{
                            withAnimation(.spring()){
                                isShowing = false
                            }
                        }label: {
                            Image(systemName: "xmark")
                                .font(.title.bold())
                                .foregroundColor(Color.theme.white)
                                .frame(width: 32,height: 32)
                                .padding()
                        }.offset(y: -60)
                    }.padding(.horizontal,20)
                        .padding(.trailing,5)
                        .padding(.bottom)
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(isShowing: .constant(false))
            .environmentObject(SliderViewModel())
            .environmentObject(UserViewModel())
    }
}

struct Sidbar {
    let id = UUID().uuidString
    let title: String
    let image: String
}
