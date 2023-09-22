//
//  CartViewModel.swift
//  BiarFoodiphone
//
//  Created by Ecc on 15/09/2023.
//

import Foundation
import Combine
class CartViewModel: ObservableObject {
    @Published var cartProductsId = [CartModel]()
    @Published var cartProducts = [Product]()
    @Published var cartProductsCount = 0
    
    private let cartRepo = CartRepository.shared
    private var cancellable = Set<AnyCancellable>()

    
    init(){
        cartRepo.cartProductsId
            .sink{[weak self] productsId in
            guard let self else {return}
            self.cartProductsId = productsId
                self.cartProductsCount = productsId.count
        }
        .store(in: &cancellable)
        
        
        cartRepo.cartProducts
            .sink{[weak self] products in
            guard let self else {return}
            self.cartProducts = products

        }
        .store(in: &cancellable)
        
        productRemoveListner()
        
    }
    
    func productRemoveListner(){
        if self.cartProductsId.count < 1 {
            cartRepo.cartProducts.send([])
            cartRepo.cartProductsId.send([])
            self.cartProducts = []
            self.cartProductsId = []
            fetchCartProducts()
            fetchCartProductsId()
        }
    }
    
    func fetchCartProductsId(){
        cartRepo.fetchCartProductId()
    }
    
    func fetchCartProducts(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            if !self.cartProductsId.isEmpty{
                self.cartRepo.fetchCartProducts(productsId: self.cartProductsId.compactMap({ proId in
                    proId.productId
                }))
            }
        }
    }
    
    
    
    
    func ordrProducts() -> [OrderProduct]{
        var orderproducts = [OrderProduct]()
        for i in cartProductsId{
         let product = cartProducts.filter { product in
                product.id == i.productId
         }.first
            guard let product1 = product else { return [] }
            orderproducts.append(OrderProduct(id: product1.id ?? "", name: product1.title, quantity: i.quantity, netWeight: product1.netFillingQuantity, depositType: product1.deposit ? product1.depositType : nil, depositPrice: product1.deposit ? product1.depositPrice : nil, imageUrl: product1.imageUrl, price: product1.price, tax: product1.tax))
        }
        return orderproducts
    }
    
    func depositPrice() -> Double {
        return cartProductsId.reduce(0.0) { total, cartProduct in
            guard let product = cartProducts.first(where: { $0.id == cartProduct.productId }), product.deposit else {
                return total
            }
            return total + (product.depositPrice) * Double(cartProduct.quantity)
        }
    }

    func salePrice() -> Double {
        return cartProductsId.reduce(0.0) { total, cartProduct in
            guard let product = cartProducts.first(where: { $0.id == cartProduct.productId }), product.sale else {
                return total
            }
            let salePrice = (product.price ) - (product.salePrice )
            return total + salePrice * Double(cartProduct.quantity)
        }
    }

    func totalPrice() -> Double {
        return cartProductsId.reduce(0.0) { total, cartProduct in
            guard let product = cartProducts.first(where: { $0.id == cartProduct.productId }) else {
                return total
            }
            let totalProductPrice = (product.price ) * Double(cartProduct.quantity)
            return total + (totalProductPrice - salePrice()) + depositPrice()
        }
    }

    
    func quantityPlus(with id: String){
        let productCount = cartProductsId.filter { proId in
            proId.productId == id
        }.first
        
        guard let singleProductId = productCount?.quantity else {return}
        cartRepo.updateCardProductId(productId: id, quantity: singleProductId + 1)
        fetchCartProductsId()
    }
    
    func quantityminus(with id: String){
        let productCount = cartProductsId.filter { proId in
            proId.productId == id
        }.first
        guard let singleProductId = productCount?.quantity else {return}
        
        if singleProductId > 1{
            cartRepo.updateCardProductId(productId: id, quantity: singleProductId-1)
            fetchCartProductsId()
        }else{
            productRemoveListner()
            cartRepo.deleteCartProduct(with: id)
            fetchCartProductsId()
            fetchCartProducts()
        }
        
    }
    
    func deleteCartProduct(at offsets: IndexSet){
          offsets.map { cartProductsId[$0] }.forEach { productId in
               let productId = productId.productId
              cartRepo.deleteCartProduct(with: productId)
        }
    }
    
}
