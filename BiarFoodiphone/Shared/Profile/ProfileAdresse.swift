//
//  MeinProfile.swift
//  BiarFoodiphone
//
//  Created by Ecc on 18/09/2023.
//

import SwiftUI

struct ProfileAdresse: View {
    @StateObject private var viewModel = MeinProfileViewModel()
    @State private var salutation = [Strings.noSelection,Strings.mr,Strings.mrs_ms]
     var dismiss: () -> Void
    var body: some View {
                    VStack(spacing: 15){
                        Text("Bitte geben Sie ihre Adresse!")
                            .font(.title3)
                            .padding(.vertical)
                            .padding(.bottom)
                        TextField("Handynummer", text: $viewModel.phoneNumber)
                            .DefaultTextFieldModifier()
                    TextField("Straße", text: $viewModel.street)
                        .DefaultTextFieldModifier()
                    TextField("Hausnummer", text: $viewModel.houseNumber)
                        .DefaultTextFieldModifier()
                    TextField("Stadt", text: $viewModel.city)
                        .DefaultTextFieldModifier()
                    TextField("PLZ", text: $viewModel.zipCode)
                        .DefaultTextFieldModifier()
                    TextField("Land", text: $viewModel.country)
                        .DefaultTextFieldModifier()
                        Spacer()
                        Button{
                            viewModel.loading = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+2){
                                Task{
                                    withAnimation(.easeInOut(duration: 0.5)){
                                        viewModel.updateUserData()
                                        dismiss()
                                        viewModel.loading = false
                                    }
                                    viewModel.fetchUserData()
                                }
                               
                            }
                           
                        }label: {
                            if viewModel.loading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            }else {
                                Text("Speichern")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                           
                              
                        }.buttonStyle(PlainButtonStyle())
                            .frame(width: 300,height: 50)
                            .background(Color.theme.greenColor)
                            .cornerRadius(15)
                            .disabled(viewModel.saveButtonDisable)
                }
       
        .padding()
        .background(Color.theme.backgroundColor)

    }
}

struct MeinProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileAdresse(dismiss: {})
    }
}
