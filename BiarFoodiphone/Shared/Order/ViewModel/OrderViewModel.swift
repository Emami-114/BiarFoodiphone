//
//  OrderViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 18/09/2023.
//

import Foundation
import SwiftUI
import Combine
class OrderViewModel: ObservableObject {
    @Published var currentView: OrderEnum = .adress
    @Published var deliveryTime: Date = Date()
    @Published var payment: PaymentEnum = .cash
    @Published  var loading = false
    private let orderRepository = OrderRepository.shared
    private let userRepository = UserRepository.shared
    @Published var successful: Bool = false

    @Published var paymentSuccess: Bool = false
    @Published var products: [OrderProduct] = []
    private var cancellable = Set<AnyCancellable>()
    init(products: [OrderProduct]){
        self.products = products
    }
    
    
    
    func createOrder(customerName: String,customerAdress: String,customerZip: String,customerCity: String){
        loading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            self.orderRepository.createOrder(successful: self.successful, customerName: customerName, customerAdress: customerAdress, customerZip: customerZip, customerCity: customerCity, deliveryDate: self.deliveryTime, paymentType: self.payment.title, paymentSuccess: self.paymentSuccess, products: self.products)
                self.deleteuserCart()
            self.successful = true
            self.loading = false
        }
       
    }
    
    func deleteuserCart(){
        orderRepository.deleteAllCartProduct(indexSet: products.map({ orderProduct in
            orderProduct.id
        }))
    }
    
    
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
    
    var title: String{
        switch self{
        case .paypal:
            return "Paypal"
        case .cash:
            return "Barzahlung"
        }
    }
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
