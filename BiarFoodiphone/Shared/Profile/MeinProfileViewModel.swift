//
//  MeinProfileViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 18/09/2023.
//

import Foundation
import Combine
class MeinProfileViewModel: ObservableObject {
    @Published var salutation: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var street: String = ""
    @Published var houseNumber : String = ""
    @Published var zipCode : String = ""
    @Published var email: String = ""
    @Published var emailConfirm = false
    @Published var phoneNumber = ""
    @Published var country = ""
    @Published var city = ""
    
    let userRepository = UserRepository.shared
    var cancellable = Set<AnyCancellable>()
    
    
    init(){
        userRepository.user.sink{[weak self] user in
            guard let self else {return}
            guard let user = user else {return}
            self._salutation = Published(initialValue: user.salutation)
            self._firstName = Published(initialValue: user.firstName)
            self._lastName = Published(initialValue: user.lastName)
            self._street = Published(initialValue: user.street)
            self._houseNumber = Published(initialValue: user.houseNumBer)
            self._zipCode = Published(initialValue: user.zipCode)
            self._email = Published(initialValue: user.email)
            self._emailConfirm = Published(initialValue: user.emailConfirm)
            self._phoneNumber = Published(initialValue: user.phoneNumber)
            self._country = Published(initialValue: user.country)
            self._city = Published(initialValue: user.city)
        }.store(in: &cancellable)
    }
    
    func updateUserData(){
        userRepository.updateUserData(email: email, salutation: salutation, firstName: firstName, lastName: lastName, street: street, houseNumBer: houseNumber, zipCode: zipCode, phoneNumber: phoneNumber, country: country, city: city)
    }
}
