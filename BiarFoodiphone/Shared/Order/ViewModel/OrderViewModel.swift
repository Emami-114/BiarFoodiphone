//
//  OrderViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 18/09/2023.
//

import Foundation
import SwiftUI
class OrderViewModel: ObservableObject {
    @Published var currentView: OrderEnum = .adress
    @Published var deliveryTime: Date = Date()
    @Published var payment: PaymentEnum = .cash
    
    var view : AnyView {
        switch currentView {
        case .adress:
            return AnyView(OrderAdress())
        case .deliverytime:
           return AnyView(DeliveryTime())
        case .payment:
            return AnyView(PaymentView())
        }
    }
}

enum PaymentEnum{
    case paypal
    case cash
}


enum OrderEnum: Int,CaseIterable{
    case adress,deliverytime,payment
    var id: Int {
        switch self{
        case .adress:
            return 1
        case .deliverytime:
            return 2
        case .payment:
            return 3
        }
    }
}
