//
//  SignUpView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 31/08/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var sidbarViewModel: SidbarViewModel
    @StateObject var viewModel = SignupViewModel()
    @State var showPassword: Bool = false
    let listSalutation = ["Kein Auswahl","Herr","Frau"]
    var body: some View {
        
        VStack(spacing: 10){
            VStack{
                Text("Neues Konto erstellen")
                    .font(.title2.bold())
                    .foregroundColor(Color.theme.blackColor)
            }.padding(.bottom)
           
            HStack{
                Text("Anrede")
                Spacer()
                Picker("", selection: $viewModel.salutation) {
                    ForEach(listSalutation,id: \.self) { salutation in
                        Text(salutation).tag(salutation)
                    }
                }
                
            }.frame(maxWidth: .infinity)
                .DefaultTextFieldModifier(frameHeight: 36, paddingHorizontal: 40)
         
                TextField("Vorname", text: $viewModel.firstName,prompt: Text("Vorname").foregroundColor(Color.theme.subTextColor.opacity(0.5)))
                .DefaultTextFieldModifier(frameHeight: 38, paddingHorizontal: 40)
                TextField("Nachname", text: $viewModel.lastName,prompt: Text("Nachname").foregroundColor(Color.theme.subTextColor.opacity(0.5)))
                .DefaultTextFieldModifier(frameHeight: 38, paddingHorizontal: 40)
                TextField("E-Mail Adresse", text: $viewModel.email,prompt: Text("E-Mail Adresse").foregroundColor(Color.theme.subTextColor.opacity(0.5)))
                
                .DefaultTextFieldModifier(frameHeight: 38, paddingHorizontal: 40)
                    .keyboardType(.emailAddress)
            
            HStack{
                if showPassword {
                    TextField("Password(mind. 6 Zeichen)", text: $viewModel.password,prompt: Text("Password(mind. 6 Zeichen)").foregroundColor(Color.theme.subTextColor.opacity(0.5)))

                }else{
                    SecureField("Password(mind. 6 Zeichen)", text: $viewModel.password,prompt: Text("Password(mind. 6 Zeichen)").foregroundColor(Color.theme.subTextColor.opacity(0.5)))
                }
                Button{
                    self.showPassword.toggle()
                }label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                }
            }
            .DefaultTextFieldModifier(frameHeight: 38, paddingHorizontal: 40)
            if !viewModel.password.isEmpty,
               viewModel.password.count < 6 {
                Label("Password(mind. 6 Zeichen", systemImage: "xmark.circle")
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            SecureField("Passwort bestätigen", text: $viewModel.passwordReentry,prompt: Text("Passwort bestätigen").foregroundColor(Color.theme.subTextColor.opacity(0.5)))
                .DefaultTextFieldModifier(frameHeight: 38, paddingHorizontal: 40)
            if !viewModel.password.isEmpty,
               !viewModel.passwordReentry.isEmpty,
               viewModel.password != viewModel.passwordReentry {
                Label("Kennwort stimmt nicht überein", systemImage: "xmark.circle")
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            
            Button{
             viewModel.register()
            sidbarViewModel.currentItem = nil
            }label: {
                Text("Registrieren")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(8)
                    .frame(width: 200)
                    .background(Color.theme.greenColor)
                    .cornerRadius(10)
            }.buttonStyle(.plain)
            .disabled(viewModel.disableAuthenticationButton)
            .padding(.top,10)
            
        }.offset(x: 30)
            .rotation3DEffect(Angle(degrees: 5), axis: (x: 0, y: 0, z: -3))
        

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(SliderViewModel())
    }
}
