//
//  SearchView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 22/09/2023.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        VStack{
            CustomNavBarView(title: "Suchen", trillingButtonAction: {}, backButtonAction: {})
            Spacer()
        }
    }
}

#Preview {
    SearchView()
}
