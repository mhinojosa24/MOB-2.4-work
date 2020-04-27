//
//  CartManager.swift
//  PatternsPrac
//
//  Created by Student Loaner 3 on 4/8/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation


protocol CartSubscriber: CustomStringConvertible {
    func accept(changed cart: [Product])
}



final class CartManager {
    lazy var cart = [Product]()
    private lazy var subscribers = [CartSubscriber]()
    
    func add(subscriber: CartSubscriber) {
        print("CartManager: I'm adding a new subscriber \(subscriber.description)")
        subscribers.append(subscriber)
    }
    
    func add(product: Product) {
        print("\nCartManager: I'm adding a new product \(product.productName)")
        cart.insert(product, at: 0)
        updateSubcribers()
    }
    
    func remove(product: Product) {
        guard let index = cart.firstIndex(where: { $0.isEqual(to: product) }) else { return }
        print("\nCartManager: Product \(product.productName) is removed from cart")
        cart.remove(at: index)
        updateSubcribers()
    }
    
    private func updateSubcribers() {
        subscribers.forEach({ $0.accept(changed: cart) })
    }
}

