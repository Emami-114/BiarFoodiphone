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
    @Published var adressResult = [AdressProperties]()
    @Published var selectedAdresse : AdressProperties? = nil
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
    @Published var userId = ""
    
    
    
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
    let adressAutocompleteRepository = AdressAutocompleteRepository.shared
    var cancellable = Set<AnyCancellable>()
    
    
    init(){
        userRepository.user.sink{[weak self] user in
            guard let self else {return}
            guard let user = user else {return}
            self.salutation = user.salutation
            self.firstName = user.firstName
            self.lastName = user.lastName
            self.street = user.street
            self.houseNumber = user.houseNumBer
            self.zipCode = user.zipCode
            self.email = user.email
            self.phoneNumber = user.phoneNumber
            self.country = user.country
            self.city = user.city
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
    
    func selectedAdresseReplace(){
        guard let terms = self.selectedAdresse?.terms else {return}
      
        self.street2 = terms[0].value
        self.city2 = terms[1].value
//        self.zipCode2 = terms.count == 3 ? terms[2].value : ""
//        self.city2 = terms.contains(inde) ? terms[3].value : ""
//        self.country2 = terms.count == 4 ? terms[4].value : ""
        
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
    
    func fetchAdresseCompletet(adreese: String)async throws {
                let adressResult2 = try await self.adressAutocompleteRepository
                    .autoCompletet(input: adreese)
                self.adressResult = adressResult2

    }
    
}
