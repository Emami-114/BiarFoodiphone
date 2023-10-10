//
//  OrderViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 18/09/2023.
//

import Foundation
import SwiftUI
import Combine
import BraintreeCore
import BraintreePayPal
class OrderViewModel: ObservableObject {
    @Published var currentView: OrderEnum = .adress
    @Published var deliveryTime: Date = Date()
    @Published var payment: PaymentEnum = .cash
    @Published  var loading = false
    private let orderRepository = OrderRepository.shared
    private let userRepository = UserRepository.shared
    private let cartRepository = CartRepository.shared
    private let sendEmail = SendSmtpMail.shared
    
    @Published var error: Error? = nil
    @Published var paymentToken: String? = nil
    
    
    @Published var successful: Bool = false
    //    @Published var email: String
    @Published var totalPrice: Double
    @Published var deliveryAddressDifferent: Bool = false
    @Published var paymentSuccess: Bool = false
    @Published var products: [InvoiceProduct] = []
    
    private var cancellable = Set<AnyCancellable>()
    init(products: [InvoiceProduct],totalPrice: Double){
        self.products = products
        self.totalPrice = totalPrice
   
    }
    
    func pay(email : String,street: String ,houseNumber:String,firstName : String,lastName: String,zipCode: String,city: String){
        let invoice = Invoice(
            userId: userRepository.user.value?.id ?? "",
            successful: successful,
            customerName: "\(firstName) \(lastName)",
            customerAdress: "\(street) \(houseNumber)",
            customerZip: zipCode,
            customerCity: city,
            deliveryDate: deliveryTime,
            paymentType: payment.title,
            paymentSuccess: paymentSuccess,
            email: email,
            invoiceNum: generateInvoiceNum(),
            totalPrice: totalPrice,
            deliveryAddressDifferent: deliveryAddressDifferent,
            products: products,paymentToken: paymentToken)
                loading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            if self.payment == .cash {
                self.paymentSuccess = true
                self.sendEmail.SendEmail(invoiceData: invoice)
                self.createOrder(email: email, street: street, houseNumber: houseNumber, firstName: firstName, lastName: lastName, zipCode: zipCode, city: city,paymentSuccess: true)
            }else if self.payment == .paypal {
                Task{
                    self.InitiatePaypalPayment(email: email, street: street, houseNumber: houseNumber, firstName: firstName, lastName: lastName, zipCode: zipCode, city: city, action: {
                        self.sendEmail.SendEmail(invoiceData: invoice)
                    })
                }
               
              
            }
        
        }
    }
    
    private func createOrder(email : String,street: String ,houseNumber:String,firstName : String,lastName: String,zipCode: String,city: String,paymentSuccess: Bool){
            self.orderRepository.createOrder(
                successful: self.successful,
                customerName: "\(firstName) \(lastName)",
                customerAdress: "\(street) \(houseNumber)",
                customerZip: zipCode,
                customerCity: city,
                deliveryDate: self.deliveryTime,
                paymentType: self.payment.title,
                paymentSuccess: paymentSuccess,
                products: self.products,
                email: email,
                invoiceNum: self.generateInvoiceNum(),
                totalPrice: self.totalPrice,
                deliveryAddressDifferent: self.deliveryAddressDifferent,
                paymentToken : self.paymentToken
            )
    }
    
    func deleteCartProducts(){
       DispatchQueue.main.async {
           self.orderRepository.deleteAllCartProduct(indexSet: self.products.map({ orderProduct in
               orderProduct.id
           }))
           self.cartRepository.cartProductsId.send([])
           self.cartRepository.listener?.remove()
           self.cartRepository.cartProducts.send([])
       }
     
    }
    
   private func generateInvoiceNum() -> String{
        let date = Date()
       let dataFormatter = DateFormatter()
       dataFormatter.dateFormat = "dd.MM.yy"
       let dateFormat = dataFormatter.string(from: date)
        let random = (1...50).randomElement()
       return "\(random ?? 0)\(dateFormat)"
        
    }
 
}
extension OrderViewModel{
    private  func InitiatePaypalPayment(email : String,street: String ,houseNumber:String,firstName : String,lastName: String,zipCode: String,city: String,action: @escaping () -> Void){
        guard let braintreeClient = BTAPIClient(authorization: "sandbox_6m26f3h6_vxc2k8yj6tkhcsc9") else {return}
        
        let paypalClient = BTPayPalClient(apiClient: braintreeClient)
        
        let checkoutRequest = BTPayPalCheckoutRequest(amount: "1.00")
        checkoutRequest.currencyCode = "EUR"
        checkoutRequest.displayName = "Biarfood"
        checkoutRequest.isShippingAddressEditable = false
        paypalClient.tokenize(checkoutRequest) { tokenizedPaypalAccount, error in
            
            if let tokenizedPaypalAccount = tokenizedPaypalAccount {
                print("Got a nonce: \(tokenizedPaypalAccount.nonce)")
                self.paymentToken = tokenizedPaypalAccount.nonce
            }
            if let error = error {
                print("Paypal error: \(error.localizedDescription)")
                self.error = error
            }else {
                print("Paypal bezahlung war erfolgreich!")
                self.paymentSuccess = true
                self.createOrder(email: email, street: street, houseNumber: houseNumber, firstName: firstName, lastName: lastName, zipCode: zipCode, city: city,paymentSuccess: true)
                action()
            }
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
