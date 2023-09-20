//
//  BiarFoodiphoneApp.swift
//  BiarFoodiphone
//
//  Created by Ecc on 28/08/2023.
//

import SwiftUI
import Firebase
@main
struct BiarFoodiphoneApp: App {
    init(){
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()

    }
    
    var body: some Scene {
        WindowGroup {
//            SignUpView()
            ContentView()
                .environmentObject(userViewModel)
//            AuthenticationView()
        }
    }
    
    @StateObject private var userViewModel = UserViewModel()
}
