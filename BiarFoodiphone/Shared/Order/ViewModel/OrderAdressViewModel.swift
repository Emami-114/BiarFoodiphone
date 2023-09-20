//
//  OrderAdressViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 18/09/2023.
//

import Foundation
import Combine
class OrderAdressViewModel: ObservableObject {
    
    @Published var loading = false
    
    @Published var salutation: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var street: String = ""
    @Published var houseNumber : String = ""
    @Published var zipCode : String = ""
    @Published var email: String = ""
    @Published var phoneNumber = ""
    @Published var country = ""
    @Published var city = ""
    
    
    
    @Published var firstName2: String = ""
    @Published var lastName2: String = ""
    @Published var street2: String = ""
    @Published var houseNumber2 : String = ""
    @Published var zipCode2 : String = ""
    @Published var email2: String = ""
    @Published var phoneNumber2 = ""
    @Published var country2 = ""
    @Published var city2 = ""
    
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
            self._phoneNumber = Published(initialValue: user.phoneNumber)
            self._country = Published(initialValue: user.country)
            self._city = Published(initialValue: user.city)
        }.store(in: &cancellable)
    }
    
    func newAdresse(){

            self._firstName = Published(initialValue: self.firstName2)
            self._lastName = Published(initialValue: self.lastName2)
            self._street = Published(initialValue: self.street2)
            self._houseNumber = Published(initialValue: self.houseNumber2)
            self._zipCode = Published(initialValue: self.zipCode2)
            self._email = Published(initialValue: self.email2)
            self._phoneNumber = Published(initialValue: self.phoneNumber2)
            self._country = Published(initialValue: self.country2)
            self._city = Published(initialValue: self.city2)
         
    }
    
    func oldAdresse(){
            self._firstName2 = Published(initialValue: self.firstName)
            self._lastName2 = Published(initialValue: self.lastName)
            self._street2 = Published(initialValue: self.street)
            self._houseNumber2 = Published(initialValue: self.houseNumber)
            self._zipCode2 = Published(initialValue: self.zipCode)
            self._email2 = Published(initialValue: self.email)
            self._phoneNumber2 = Published(initialValue: self.phoneNumber)
            self._country2 = Published(initialValue: self.country)
            self._city2 = Published(initialValue: self.city)
    }
    
     func removeFields(){
        self.firstName2 = ""
        self.lastName2 = ""
        self.street2 = ""
        self.houseNumber = ""
        self.zipCode2 = ""
        self.email2 = ""
        self.phoneNumber2 = ""
        self.country2 = ""
        self.city2 = ""
    }
    
}
