//
//  ForgotPassword.swift
//  BiarFoodiphone
//
//  Created by Ecc on 21/09/2023.
//

import SwiftUI

//
//  SignInView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 31/08/2023.
//

import SwiftUI

struct ForgotPassword: View {
    @EnvironmentObject var sidbarViewModel: SidbarViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    var action: () -> Void
  
    var body: some View {
        VStack(spacing: 20){
            VStack{
                Text(Strings.resetPassword)
                    .font(.title2.bold())
                    .foregroundColor(Color.theme.blackColor)
                Text(Strings.pleaseEnterYourEmailAddress)
                    .foregroundColor(Color.theme.subTextColor)
                    .font(.caption)
            }.padding(.bottom)
            TextField(Strings.emailAddress, text: $userViewModel.email)
                    .DefaultTextFieldModifier(paddingHorizontal: 40)
                    .keyboardType(.emailAddress)
            
            Button{
               
            }label: {
                if userViewModel.userIsLogged{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.white))
                }else{
                    Text(Strings.resetPassword)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                
                  
            }.padding(10)
            .frame(width: 200)
                .background(Color.theme.greenColor)
                .cornerRadius(10)
            .buttonStyle(.plain)
            .padding(.top)
            
        }.offset(x: 30)
            .rotation3DEffect(Angle(degrees: 5), axis: (x: 0, y: 0, z: -3))
    }
}

#Preview {
    ForgotPassword(action: {})
        .environmentObject(UserViewModel())
}
