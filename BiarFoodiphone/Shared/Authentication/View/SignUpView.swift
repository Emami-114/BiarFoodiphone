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
    let listSalutation = [Strings.noSelection,Strings.mr,Strings.mrs_ms]
    var body: some View {
        
        VStack(spacing: 10){
            VStack{
                Text(Strings.createAnewAccount)
                    .font(.title2.bold())
                    .foregroundColor(Color.theme.blackColor)
            }.padding(.bottom)
           
            HStack{
                Text(Strings.salutation)
                Spacer()
                Picker("", selection: $viewModel.salutation) {
                    ForEach(listSalutation,id: \.self) { salutation in
                        Text(salutation).tag(salutation)
                    }
                }
                
            }.frame(maxWidth: .infinity)
                .DefaultTextFieldModifier(frameHeight: 36, paddingHorizontal: 40)
         
            TextField(Strings.firstName, text: $viewModel.firstName)
                .DefaultTextFieldModifier(frameHeight: 38, paddingHorizontal: 40)
            TextField(Strings.lastName, text: $viewModel.lastName)
                .DefaultTextFieldModifier(frameHeight: 38, paddingHorizontal: 40)
            TextField(Strings.emailAddress, text: $viewModel.email)
                
                .DefaultTextFieldModifier(frameHeight: 38, paddingHorizontal: 40)
                    .keyboardType(.emailAddress)
            
            HStack{
                if showPassword {
                    TextField(Strings.passwordMin6, text: $viewModel.password)

                }else{
                    SecureField(Strings.passwordMin6, text: $viewModel.password)
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
                Label(Strings.passwordMin6, systemImage: "xmark.circle")
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            SecureField(Strings.confirmPassword, text: $viewModel.passwordReentry)
                .DefaultTextFieldModifier(frameHeight: 38, paddingHorizontal: 40)
            if !viewModel.password.isEmpty,
               !viewModel.passwordReentry.isEmpty,
               viewModel.password != viewModel.passwordReentry {
                Label(Strings.passwordDoesNotMatch, systemImage: "xmark.circle")
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            
            Button{
                if viewModel.userIsLogged{
                    sidbarViewModel.currentItem = nil
                }else{
                    viewModel.register()
                }
            }label: {
                if viewModel.loading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.white))
                }else{
                    Text(Strings.signUp)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }.buttonStyle(.plain)
                .padding(8)
                .frame(width: 200)
                .background(Color.theme.greenColor)
                .cornerRadius(10)
            .disabled(viewModel.disableAuthenticationButton)
            .padding(.top,10)
            
        }.offset(x: 30)
            .rotation3DEffect(Angle(degrees: 5), axis: (x: 0, y: 0, z: -3))
        
            .alert(Strings.error, isPresented: $viewModel.showAlert) {
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(SliderViewModel())
    }
}
