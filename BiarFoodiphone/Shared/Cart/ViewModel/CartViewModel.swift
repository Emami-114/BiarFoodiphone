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
    
    
    func depositPrice() -> Double{
        var totalDepositPrice = 0.0
        for i in cartProductsId{
         let product = cartProducts.filter { product in
                product.id == i.productId
         }.first
            if product?.deposit ?? false{
                let depositPreise = product?.depositPrice ?? 0.0
                totalDepositPrice = totalDepositPrice + depositPreise  * Double(i.quantity)
            }
        }
        return totalDepositPrice
    }
    
    func salePrice() -> Double{
        var totalSalePrice = 0.0
        for i in cartProductsId{
         let product = cartProducts.filter { product in
                product.id == i.productId
         }.first
            if product?.sale ?? false{
                let salePrice = (product?.price ?? 0.0) - (product?.salePrice ?? 0.0)
                totalSalePrice = totalSalePrice + salePrice * Double(i.quantity)
            }
        }
        return totalSalePrice
    }
    
    
    func totalPrice() -> Double{
        var totalprice = 0.0
        for i in cartProductsId{
         let product = cartProducts.filter { product in
                product.id == i.productId
         }.first
            let totalproductprice = (product?.price ?? 0.0) * Double(i.quantity)
            totalprice = totalprice + (totalproductprice - salePrice()) + depositPrice()
        }
        return totalprice
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
    
    func deleteCartProduct(with id: String){
        cartRepo.deleteCartProduct(with: id)
    }
    
}
