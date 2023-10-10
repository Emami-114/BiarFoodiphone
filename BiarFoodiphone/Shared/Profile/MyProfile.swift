//
//  MyProfile.swift
//  BiarFoodiphone
//
//  Created by Ecc on 09/10/2023.
//

import SwiftUI

struct MyProfile: View {
    @EnvironmentObject var viewModel : SidbarViewModel
    var body: some View {
        VStack{
            CustomNavBarView(title: "Mein Profile",trillingButtonAction: {}, backButtonAction: {
                viewModel.currentItem = nil
            })
            
            Spacer()
        }
    }
}

#Preview {
    MyProfile()
}
