//
//  SignInView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 31/08/2023.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SigninViewModel()
    @EnvironmentObject var sidbarViewModel: SidbarViewModel
    @State var showAlert = false
    @FocusState private var focusStateField
    @State var showPassword: Bool = false
    var action: () -> Void
  
    var body: some View {
        VStack(spacing: 20){
            VStack{
                Text("Willkommen zurück!")
                    .font(.title2.bold())
                    .foregroundColor(Color.theme.blackColor)
                Text("Bitte geben Sie Ihre E-Mail-Adresse und Ihr Kennwort an.")
                    .foregroundColor(Color.theme.subTextColor)
                    .font(.caption)
            }.padding(.bottom)
            TextField("E-mail", text: $viewModel.email,prompt: Text("E-mail").foregroundColor(Color.theme.subTextColor.opacity(0.5)))
                    .DefaultTextFieldModifier(paddingHorizontal: 40)
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
            }.DefaultTextFieldModifier(paddingHorizontal: 40)

            Button{
                action()
            }label: {
                Text("Password vergessen?")
            }
            
            
            Button{
                if !viewModel.userIsLogged{
                    viewModel.login()
                }else {
                    sidbarViewModel.currentItem = nil
                }
            }label: {
                if viewModel.loading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.white))
                }else{
                    Text("Anmelden")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                
                  
            }.padding(10)
            .frame(width: 200)
                .background(Color.theme.greenColor)
                .cornerRadius(10)
            .buttonStyle(.plain)
            .disabled(viewModel.disableAuthenticationButton)
            .padding(.top)
            
        }.offset(x: 30)
            .rotation3DEffect(Angle(degrees: 5), axis: (x: 0, y: 0, z: -3))
        
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button(role: .cancel) {
                    viewModel.errorRemove()
                } label: {
                    Text("Ok")
                }

            } message: {
                Text(viewModel.error ?? "")
            }
        
           

    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(action: {})
            .environmentObject(SidbarViewModel())
    }
}
