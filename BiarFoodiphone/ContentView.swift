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
    @StateObject private var sidbarIpdadViewModel = SiderbarIpadViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var showKontoSidbar: Bool = false

    var body: some View {
        responsiveView{ props in
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
                                SiderbarIpadView(showingKontoSidbar: $showKontoSidbar)
                                    .environmentObject(sidbarIpdadViewModel)
                                    .environmentObject(sidbarViewModel)
                                    .navigationSplitViewColumnWidth(220)
                            }, detail: {
                                if showKontoSidbar{
                                    sidbarIpdadViewModel.view
                                        .transition(.slide)
                                }else {
                                    SiderbarDetailsView(props: props)
                                        .transition(.slide)

                                }
                               
                            })
                        .navigationSplitViewStyle(.balanced)
                    }
                
            }.background(Color.theme.backgroundColor)

            .environmentObject(sidbarViewModel)
    }
    
 @ViewBuilder
    func SiderbarDetailsView(props: Properties) -> some View{
        switch self.sidbarIpdadViewModel.currentItem{
        case Strings.home:
            AnyView(HomeView(sidbarShowing: .constant(false), props: props, naviagtionToCart: {
                sidbarIpdadViewModel.currentItem = Strings.shoppingCart
            }))
        case Strings.search:
            AnyView(SearchView())
        case Strings.shoppingCart:
            AnyView(CartsView())
        case Strings.favoritSeit:
            AnyView(FavoritsView())
        default:
            AnyView(Text(""))
        }
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
