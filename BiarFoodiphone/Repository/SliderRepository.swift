//
//  SliderRepository.swift
//  BiarFoodiphone
//
//  Created by Ecc on 12/09/2023.
//

import Foundation
import Combine
class SliderRepository{
    
    static let shared = SliderRepository()
    
    var sliders = CurrentValueSubject<[Slider]?,Never>(nil)
    
}

extension SliderRepository{

    func fetchSliders(){
        FirebaseManager.shared.database.collection("sliders")
            .whereField("isPublich", isEqualTo: true)
            .addSnapshotListener { querySnapshot, error in
                if let error = error{
                    print("Fehler beim laden Sliders: \(error.localizedDescription)")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    print("Fehler beim laden sliders")
                    return}
                
                let sliders = documents.compactMap { queryDocument -> Slider? in
                   let slider = try? queryDocument.data(as: Slider.self)
                    return slider
                }
                self.sliders.send(sliders)
            }
    }
    
}

