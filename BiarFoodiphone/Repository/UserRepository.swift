//
//  UserRepository.swift
//  BiarFoodiphone
//
//  Created by Ecc on 31/08/2023.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
class UserRepository {
 static let shared = UserRepository()
    var userIsLoggedIn = CurrentValueSubject<Bool,Never>(false)
    var authError = CurrentValueSubject<String?,Never>(nil)
    var user = CurrentValueSubject<User?,Never>(nil)
    
    init(){
        checkAuth()
    }
}


extension UserRepository {
    
    private func checkAuth() {
        guard let currentUser =  FirebaseManager.shared.auth.currentUser else {
            return
        }
        
        self.userIsLoggedIn.send(true)
        self.fetchUser(width: currentUser.uid)
        
        
    }
    
    func login(email: String, password: String){
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password){authResult,error in
            if let error = error {
                print("Fehler beim Anmelden:",error.localizedDescription)
                self.authError.send(Strings.loginFailed)
                return
            }
            guard let authResult, let _ = authResult.user.email else { return }
            self.userIsLoggedIn.send(true)
            self.fetchUser(width: authResult.user.uid)
            
            
        }
    }
    
    func register(email: String,password: String, salutation: String,firstName: String,
                  lastName: String,street: String,houseNumBer : String,zipCode : String,
                  rolle: String,emailConfirm: Bool,phoneNumber: String,country: String,city: String
    ){
        
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password){authResult, error in
            if let error = error {
                print("Fehler beim Registrieren: \(error.localizedDescription)")
                self.authError.send(Strings.RegistrationFailed)
                return
            }
            guard let authResult, let email = authResult.user.email else {return}
            
            self.createUserToFireStore(with: authResult.user.uid, email: email, salutation: salutation, firstName: firstName, lastName: lastName, street: street, houseNumBer: houseNumBer, zipCode: zipCode,rolle: rolle,emailConfirm: emailConfirm,phoneNumber: phoneNumber,country: country, city: city)
            
            self.login(email: email, password: password)
            
        }
        
    }
    
    
    func logOut(){
        do{
            try FirebaseManager.shared.auth.signOut()
            self.userIsLoggedIn.send(false)
            self.user.send(nil)
            
            
        }catch{
            print("Fehler beim Abmelden: \(error.localizedDescription)")
        }
    }
    
    func updateUserData(email: String,salutation: String,firstName: String,lastName: String,street: String,houseNumBer : String,zipCode : String,phoneNumber: String,country: String,city: String){
        guard let userId = user.value?.id else {return}
        let data: [String: Any] = [
            "email" : email,
            "salutation" : salutation,
            "firstName": firstName,
            "lastName": lastName,
            "street": street,
            "houseNumBer": houseNumBer,
            "zipCode" : zipCode,
            "phoneNumber": phoneNumber,
            "country" : country,
            "city": city
        ]
        FirebaseManager.shared.database.collection("users").document(userId).setData(data, merge: true){error in
            if error != nil {
                print("User update fehlgeschlagen")
                return
            }
        }
        
    }
    
}


extension UserRepository {

    private func createUserToFireStore(with id: String, email: String,salutation: String,firstName: String,lastName: String,street: String,houseNumBer : String,zipCode : String,rolle: String,emailConfirm: Bool,phoneNumber: String,country: String,city:String){
        
        
        let user = User(id: id, salutation: salutation, firstName: firstName, lastName: lastName, street: street, houseNumBer: houseNumBer, zipCode: zipCode, email: email,rolle: rolle,emailConfirm: emailConfirm,phoneNumber: phoneNumber, city: city,country: country)
        
        do {
            try FirebaseManager.shared.database.collection("users").document(id).setData(from: user)
        }catch let error {
            print("Fehler beim Speichern das Users: \(error)")
        }
    }
    
    private func fetchUser(width id: String){
        FirebaseManager.shared.database.collection("users").document(id).getDocument { document, error in
            if let error = error {
                print("Fetching user failed: \(error.localizedDescription)")
                return
            }
            
            guard let document else {
                print("Dukument existiert nicht!")
                return
            }
            do {
                let user = try document.data(as: User.self)
                self.user.send(user)
            }catch{
                print("Dokument is kein User: \(error.localizedDescription)")
            }
            
            
        }
    }
    
   
    
    
}
