//
//  ProductTabView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 31/08/2023.
//

import SwiftUI

struct ProductTabView: View {
    @EnvironmentObject var categoryViewModel : CategorieViewModel
    @EnvironmentObject var productViewModel : ProductsViewModel
  
    var body: some View {
        let mainCategories = categoryViewModel.categories.filter { category in
            category.type == "Main"
        }
        let subCategorie = categoryViewModel.categories.filter { subCategorie in
            subCategorie.mainId == productViewModel.selectedCategorie
        }
        
        VStack (spacing: 0){
            TabBarView(currenTab: $productViewModel.selectedCategorie, tabBarOption: mainCategories,fetchProduct: {
                productViewModel.fetchProducts()
                productViewModel.selectedSubCategorie = subCategorie.first?.id ?? ""

            })
           
            TabBarSubView(currenTab: $productViewModel.selectedSubCategorie, tabBarOption: categoryViewModel.filterSubCategories(selectedMain: productViewModel.selectedCategorie))
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
                        HStack(spacing: 25){
                                ForEach(tabBarOption,id: \.id) {tab in
                                    TabBarItem(tabBarItemName: tab.name, nameSpace: nameSpace, currentTab: self.$currenTab, tabID: tab.id ?? "",fetchProduct: fetchProduct)
                                        .tag(tab.id ?? "")
                                }
                            
                            }
            }
            Spacer()
        }.padding(.horizontal)
        .frame(height: 44,alignment: .top)
        .background(Color.theme.greenColor)
    }
}

struct TabBarItem:View {
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
                    .foregroundColor(Color.theme.white)
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
   
    var body: some View{
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 20){
                            ForEach(tabBarOption,id: \.id) {tab in
                                TabBarSubItem(tabBarItemName: tab.name, nameSpace: nameSpace, currentTab: self.$currenTab, tabID: tab.id ?? "")
                            }
                        
                    }
                   
                }
                .padding(.horizontal)
                .frame(height: 50,alignment: .center)
                .background(Color.clear)
                
    }
}

struct TabBarSubItem:View {
    var tabBarItemName : String
    let nameSpace: Namespace.ID
    @Binding var currentTab : String
    var tabID : String

    
    var body: some View{
        Button{
            self.currentTab = tabID
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
        ProductTabView()
            .environmentObject(CategorieViewModel())
            .environmentObject(ProductsViewModel())
        

    }
}
