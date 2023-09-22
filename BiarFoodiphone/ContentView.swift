//
//  ContentView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State var currenTab = "Profile"
    @State var isShowingSidebar = false
    @State var navigationShow : NavigationSplitViewVisibility = .all
    @StateObject private var sidbarViewModel = SidbarViewModel()
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        responsiveView{ props in
//                NavigationStack{
                if !(props.isIpad || props.isLandscape){
                        if isShowingSidebar {
                                    SidebarView(isShowing: $isShowingSidebar)
                        }
                    if sidbarViewModel.currentItem == nil{
                        BottomBarView(props: props, showSiderBar: $isShowingSidebar)
                            .cornerRadius(isShowingSidebar ? 40 : 0)
                            .padding(isShowingSidebar ? 20 : 0)
                            .background(isShowingSidebar ? Color.theme.white.opacity(0.2) : .clear)
                            .cornerRadius(isShowingSidebar ? 40 : 0)
                            .padding(isShowingSidebar ? 20 : 0)
                            .background(isShowingSidebar ? Color.theme.white.opacity(0.4) : .clear)
                            .cornerRadius(isShowingSidebar ? 40 : 0)
                            .offset(x: isShowingSidebar ? 220 : 0,y: isShowingSidebar ? 44 : 0)
                            .scaleEffect(isShowingSidebar ? 0.77 : 1)
                            .rotation3DEffect(Angle(degrees: isShowingSidebar ? 40 : 0), axis: (x: 0, y:isShowingSidebar ? -10 : 0, z: 0))
                            .ignoresSafeArea(.all,edges: .all)

                    }else{
                        sidbarViewModel.view
                    }
                           
                    }else{
                        NavigationSplitView(columnVisibility: $navigationShow, sidebar: {
                            SidebarView(isShowing: $isShowingSidebar)
//                                .environmentObject(sidbarViewModel)

                        }, detail: {
                            HomeView(sidbarShowing: $isShowingSidebar, props: props, naviagtionToCart: {})

                        }).navigationSplitViewStyle(.balanced)
                            
                    }
      
//            }
                    
            }.background(Color.theme.backgroundColor)

            .environmentObject(sidbarViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 14 Pro")
                .environmentObject(UserViewModel())
          

        }
    }
}
