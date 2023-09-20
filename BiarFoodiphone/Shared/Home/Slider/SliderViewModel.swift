//
//  SliderViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 12/09/2023.
//

import Foundation
import Combine
class SliderViewModel:  ObservableObject {
    @Published var sliders: [Slider]? = (nil)
    let sliderRepository = SliderRepository.shared
    var cancellable = Set<AnyCancellable>()
    init(){
        sliderRepository.sliders.sink {[weak self] sliders in
            guard let self else {return}
            self.sliders = sliders
        }
        .store(in: &cancellable)
        fetchSlider()
    }
    
    
    func fetchSlider() {
        sliderRepository.fetchSliders()
    }
}
