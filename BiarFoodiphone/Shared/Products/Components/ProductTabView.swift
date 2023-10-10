//
//  ProductTabView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 31/08/2023.
//

import SwiftUI

struct ProductTabView: View {
    @EnvironmentObject var productViewModel : ProductsViewModel
    var action: (String) -> Void
    var body: some View {
        VStack (spacing: 0){
            TabBarView(currenTab: $productViewModel.selectedCategorie, tabBarOption: productViewModel.mainCategories,fetchProduct: {
                productViewModel.fetchProducts()
                productViewModel.filterSubCategories()
            })
            
            TabBarSubView(currenTab: $productViewModel.selectedSubCategorie, tabBarOption: productViewModel.subCategories, action: {string in
            action(string)
            })
            
        }
    }
}

struct TabBarView: View {
    @Binding var currenTab : String
    var tabBarOption: [Category]
    @Namespace var nameSpace
    var fetchProduct : () -> Void
    var body: some View{
        VStack {
            ScrollView(.horizontal,showsIndicators: false) {
                ScrollViewReader {proxy in
                    HStack(spacing: 25){
                        ForEach(tabBarOption,id: \.id) {tab in
                            TabBarItem(tabBarItemName: tab.name, nameSpace: nameSpace, currentTab: self.$currenTab, tabID: tab.id ?? "",fetchProduct: fetchProduct)
                                .tag(tab.id ?? "")
                                .id(tab.id ?? "")
                        }
                    }
                    .onChange(of: currenTab, { oldValue, newValue in
                        withAnimation(.spring()){
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    })
                    
                }
                
            }
            Spacer()
        }.padding(.horizontal)
            .frame(height: 44,alignment: .top)
            .background(Color.theme.greenColor)
    }
}

struct TabBarItem:View {
    var textColor: Color = Color.theme.white
    var tabBarItemName : String
    let nameSpace: Namespace.ID
    @Binding var currentTab : String
    var tabID : String
    var fetchProduct : () -> Void
    var body: some View{
        Button{
            self.currentTab = tabID
            fetchProduct()
        }label: {
            VStack{
                Spacer()
                Text(tabBarItemName)
                    .foregroundColor(textColor)
                    .font(.headline)
                
                if currentTab == tabID {
                    Color.red
                        .frame(height: 5)
                        .matchedGeometryEffect(id: "underline", in: nameSpace,properties: .frame)
                }else{
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: self.currentTab)
        }.buttonStyle(.plain)
    }
}

struct TabBarSubView: View {
    @Binding var currenTab : String
    var tabBarOption: [Category]
    @Namespace var nameSpace
    var action: (String) -> Void
    var body: some View{
        ScrollView(.horizontal,showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack(spacing: 20){
                    ForEach(tabBarOption,id: \.id) {tab in
                        TabBarSubItem(tabBarItemName: tab.name, nameSpace: nameSpace, currentTab: self.$currenTab, action: {string in
                        action(string)
                        }, tabID: tab.id ?? "")
                            
                            .id(tab.id ?? "")
                    }
                    
                }
                .onChange(of: currenTab, { oldValue, newValue in
                    withAnimation(.spring()){
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                })
            }
            .padding(.horizontal)
            .frame(height: 50,alignment: .center)
            .background(Color.clear)
            
        }
        
        
    }
}

struct TabBarSubItem:View {
    var tabBarItemName : String
    let nameSpace: Namespace.ID
    @Binding var currentTab : String
    var action: (String) -> Void
    var tabID : String
    
    
    var body: some View{
        Button{
            self.currentTab = tabID
                action(tabID)
            
       
        }label: {
            VStack{
                Spacer()
                let tabName = tabBarItemName
                Text(tabName).lineLimit(1)
                    .font(.footnote)
                    .foregroundColor(currentTab == tabID ? Color.theme.white : Color.theme.blackColor)
                    .padding(10)
                    .background{
                        if currentTab == tabID {
                            RoundedRectangle(cornerRadius: 8).fill(currentTab == tabID ? Color.theme.greenColor : .clear)
                                .matchedGeometryEffect(id: "Tab2", in: nameSpace)
                        }
                        
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 0.3).fill(Color.theme.subTextColor)
                    }
                
            }
            .animation(.spring(), value: self.currentTab)
        }.buttonStyle(.plain)
        
    }
}

struct ProductTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProductTabView( action: {string in })
            .environmentObject(ProductsViewModel())
        
        
    }
}
