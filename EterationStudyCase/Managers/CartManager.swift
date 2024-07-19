//
//  CartManager.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 15.07.2024.
//

import Foundation
import UIKit

protocol CartManagerProtocol {
    func saveToLocal()
    func loadFromLocal()
    func updateNumber(of product: Product, newNumber: Int)
    var totalPrice: Int { get }
    var cartProducts: Set<Product> { get }
    func addProductToCart(_ product: Product)
    func addSubscriber(proccess: @escaping Process)
    func removeSubscriber(proccess: @escaping Process)
}

typealias Process = ()->()
class CartManager: NSObject, CartManagerProtocol {
    internal static var shared = CartManager()
    
    var cartProducts: Set<Product> = []
    
    private var subscribers: [Process] = []
    
    var totalPrice = 0
    
    private override init() {
        super.init()
        loadFromLocal()
    }
    
    func saveToLocal() {
        cartProducts.forEach { product in
            LocalDataManager.shared.updateOrSaveProduct(product: product)
        }
    }
    
    func loadFromLocal() {
        cartProducts = Set(LocalDataManager.shared.loadProducts())
        updatedData()
    }
    
    private func updatedData() {
        calculateTotalPrice()
        notifySubscribers()
    }
    
    func addProductToCart(_ product: Product?) {
        guard let product else { return }
        addProductToCart(product)
    }
    
    func addProductToCart(_ product: Product) {
        if product.numberOfCart == nil || product.numberOfCart == 0 {
            var product = product
            product.numberOfCart = 1
            cartProducts.insert(product)
        } else {
            cartProducts.insert(product)
        }
        updatedData()
    }
    
    func updateNumber(of product: Product, newNumber: Int) {
        cartProducts.remove(product)
        if newNumber > 0 {
            var product = product
            product.numberOfCart = newNumber
            cartProducts.update(with: product)
        } else {
            LocalDataManager.shared.deleteProduct(product: product)
        }
        updatedData()
    }
    
    private func calculateTotalPrice() {
        var total:Int = 0
        
        cartProducts.forEach { product in
            let priceStr = product.price?.replacingOccurrences(of: ".00", with: "")
            guard let price = priceStr,
               let numberOfCart = product.numberOfCart,
               let priceInt = Int(price) else { return }
            
            total += priceInt * numberOfCart
        }
        totalPrice = total
    }
}


extension CartManager {
    private func notifySubscribers() {
        subscribers.forEach {  $0() }
    }
    
    func addSubscriber(proccess: @escaping Process) {
        self.subscribers.append(proccess)
    }
    
    func removeSubscriber(proccess: @escaping Process) {
        self.subscribers.removeAll { $0() == proccess() }
    }
}
