//
//  SearchFieldView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 10/10/2023.
//

import SwiftUI

struct SearchFieldView: View {
    @Binding var searchQuery: String
    @Binding var searchFocusState: Bool
    @FocusState private var focusState
    var action: () -> Void
    var promp = "Suchen..."
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                TextField(promp, text: $searchQuery)
                    .focused($focusState)
                    .textInputAutocapitalization(.sentences)
            }
            if focusState{
                Button{
                    focusState = false
                        action()
                }label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.gray)
                }
            }
           
        }
        .animation(.easeInOut(duration: 1), value: focusState)
        .onChange(of: focusState, { oldValue, newValue in
            if newValue == true {
                self.searchFocusState = newValue

            }
            
        })
        .DefaultTextFieldModifier(frameHeight: 40)
    }
}

#Preview {
    SearchFieldView(searchQuery: .constant(""), searchFocusState: .constant(false), action: {})
}
