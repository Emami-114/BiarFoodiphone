//
//  MeinProfile.swift
//  BiarFoodiphone
//
//  Created by Ecc on 18/09/2023.
//

import SwiftUI

struct MeinProfile: View {
    @StateObject private var viewModel = MeinProfileViewModel()
    @State private var salutation = [Strings.noSelection,Strings.mr,Strings.mrs_ms]
     var dismiss: () -> Void
    var body: some View {
            Form{
                Picker(Strings.salutation, selection: $viewModel.salutation) {
                    ForEach(salutation,id: \.self) { salou in
                        Text(salou).tag(salou)
                    }
                }
                Section("Name") {
                    TextField(Strings.firstName, text: $viewModel.firstName)
                    TextField(Strings.lastName, text: $viewModel.lastName)
                }
                Section("E-Mail") {
                    TextField(Strings.emailAddress, text: $viewModel.email)
                }
                Section("Handynummer") {
                    TextField(Strings.mobilePhoneNumber, text: $viewModel.phoneNumber)
                }
                Section("Adresse") {
                    TextField("Straße", text: $viewModel.street)
                    TextField("Hausnummer", text: $viewModel.houseNumber)
                    TextField("Stadt", text: $viewModel.zipCode)
                    TextField("PLZ", text: $viewModel.zipCode)
                    TextField("Land", text: $viewModel.country)
                }
                Section{
                    HStack{
                        Button{
                            withAnimation(.easeInOut(duration: 0.5)){
                                dismiss()

                            }
                        }label: {
                            Text("Abbrechen")
                        }.buttonStyle(.bordered)
                            .foregroundColor(.black)
                        Spacer()
                        Button{
                            viewModel.updateUserData()
                        }label: {
                            Text("Aktualisieren")
                        }.buttonStyle(.bordered)
                            .foregroundColor(.black)
                    }
                }
            }
    }
}

struct MeinProfile_Previews: PreviewProvider {
    static var previews: some View {
        MeinProfile(dismiss: {})
    }
}
