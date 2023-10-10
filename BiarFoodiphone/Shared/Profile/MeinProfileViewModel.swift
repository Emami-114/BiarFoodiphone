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
    
    @Published var adressResult = [AdressProperties]()
    @Published var selectedAdresse : AdressProperties? = nil
    
    let userRepository = UserRepository.shared
    let adressRepository = AdressAutocompleteRepository.shared
    var cancellable = Set<AnyCancellable>()
    @Published var loading = false
    
    init(){
        userRepository.user.sink{[weak self] user in
            guard let self else {return}
            guard let user = user else {return}
            self._salutation = Published(initialValue: user.salutation)
            self._firstName = Published(initialValue: user.firstName)
            self._lastName = Published(initialValue: user.lastName)
            self._email = Published(initialValue: user.email)
            self._emailConfirm = Published(initialValue: user.emailConfirm)
        }.store(in: &cancellable)
        
    }
    
    func fetchAdresseCompletet(adreese: String) async throws {
                let adressResult2 = try await self.adressRepository
                    .autoCompletet(input: adreese)
                self.adressResult = adressResult2

    }
    
    func fetchUserData(){
        userRepository.fetchUserData()
    }
    
    var saveButtonDisable: Bool {
        street.isEmpty || houseNumber.isEmpty || zipCode.isEmpty || country.isEmpty || city.isEmpty || phoneNumber.isEmpty
    }
    
    func updateUserData(){
            self.userRepository.updateUserData(email: email, salutation: salutation, firstName: firstName, lastName: lastName, street: street, houseNumBer: houseNumber, zipCode: zipCode, phoneNumber: phoneNumber, country: country, city: city)
        
    }
}
