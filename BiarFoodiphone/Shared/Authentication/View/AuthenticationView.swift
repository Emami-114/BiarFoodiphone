//
//  AuthenticationView.swift
//  BiarFoodiphone
//
//  Created by Ecc on 13/09/2023.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var viewModel = UserViewModel()
    @EnvironmentObject var sidbarViewModel: SidbarViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(colors: [
                Color.theme.greenColor.opacity(0.6),
                Color.theme.greenColor.opacity(0.8),
                Color.theme.greenColor,
                Color.theme.greenColor,
                Color.theme.greenColor.opacity(0.8),
                Color.theme.greenColor.opacity(0.6),
            
            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all,edges: .all)
            VStack(){
                HStack(spacing: 0){
                    Button{
                        withAnimation(.spring()){
                            sidbarViewModel.currentItem = nil
                            dismiss()
                        }
                     
                    }label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color.theme.white)
                            .font(.title.bold())
                    }
                    Spacer()
                    Text(viewModel.currentAuthView.title)
                        .font(.title.bold())
                        .foregroundColor(Color.theme.white)
            
                    Spacer()
                } .offset(y: 40)
                    .padding(.horizontal)

                RoundedRectangle(cornerRadius: 20).fill(Color.theme.subTextColor.opacity(0.7))
                    .frame(height: 100)
                    .overlay {
                        VStack{
                            HStack{
                                Spacer()
                                Text(viewModel.viewChangeForgot.title)
                                    .foregroundColor(Color.theme.white)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }.padding()
                            Spacer()
                        }
                    }
                    .offset(x: -80,y: 100)
                    .rotation3DEffect(Angle(degrees: -8), axis: (x: 0, y: 0, z: 3))
                    .onTapGesture {
                        withAnimation(.spring()){
                            viewModel.currentAuthView = viewModel.viewChangeForgot
                        }
                    }
                RoundedRectangle(cornerRadius: 20).fill(Color.theme.iconColor)
                    .frame(height: 100)
                    .overlay {
                        VStack{
                            HStack{
                                Spacer()
                                Text(viewModel.viewChangeSignUp.title)
                                    .foregroundColor(Color.theme.white)
                                    .font(.title2)
                                    .fontWeight(.semibold)

                            }.padding()
                                .padding(.trailing)
                            Spacer()
                        }
                    }
                    .offset(x: -40,y: 55)
                    .rotation3DEffect(Angle(degrees: -3), axis: (x: 0, y: 0, z: 3))
                    .onTapGesture {
                        withAnimation(.spring()){
                            viewModel.currentAuthView = viewModel.viewChangeSignUp
                        }
                    }
                viewModel.currentAuthView.view
                    .padding(.trailing)
                    .transition(.move(edge: .bottom))
                    .frame(minHeight: 400,maxHeight: 550)
                    .background(Color.theme.backgroundColor)
                    .cornerRadius(20)
                    .offset(x: -40)
                    .scaleEffect(1)
                    .rotation3DEffect(Angle(degrees: 5), axis: (x: 0, y: 0, z: 10))
                    .shadow(radius: 10)
                    .animation(.spring(), value: self.viewModel.currentAuthView)
                    .environmentObject(sidbarViewModel)
                Spacer()
            }.offset(y: -40)

        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(SliderViewModel())
    }
}
