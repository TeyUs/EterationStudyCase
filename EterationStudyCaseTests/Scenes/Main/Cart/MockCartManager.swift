//
//  MockCartManager.swift
//  EterationStudyCaseTests
//
//  Created by Teyhan Uslu on 19.07.2024.
//

import Foundation
@testable import EterationStudyCase

final class MockCartManager: CartManagerProtocol {
    func saveToLocal() {
        
    }
    
    func loadFromLocal() {
        
    }
    
    func updateNumber(of product: EterationStudyCase.Product, newNumber: Int) {
        
    }
    
    var totalPrice: Int = 0
    
    var cartProducts: Set<EterationStudyCase.Product> = [
        .init(createdAt: nil, name: "product1", image: nil, price: nil, description: nil, model: nil, brand: nil, id: "1"),
        .init(createdAt: nil, name: "product2", image: nil, price: nil, description: nil, model: nil, brand: nil, id: "2"),
        .init(createdAt: nil, name: "product3", image: nil, price: nil, description: nil, model: nil, brand: nil, id: "3")
    ]
    
    func addSubscriber(proccess: @escaping EterationStudyCase.Process) {
        
    }
    
    func addProductToCart(_ product: EterationStudyCase.Product) {
        
    }
    
    
}

