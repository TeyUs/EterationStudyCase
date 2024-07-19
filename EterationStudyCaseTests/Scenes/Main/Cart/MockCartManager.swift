//
//  MockCartManager.swift
//  EterationStudyCaseTests
//
//  Created by Teyhan Uslu on 19.07.2024.
//

import Foundation
@testable import EterationStudyCase

final class MockCartManager: CartManagerProtocol {
    
    
    var saveToLocalCalled = false
    var saveToLocalCallCount = 0
    func saveToLocal() {
        saveToLocalCalled = true
        saveToLocalCallCount += 1
    }
    
    var loadFromLocalCalled = false
    var loadFromLocalCallCount = 0
    func loadFromLocal() {
        loadFromLocalCalled = true
        loadFromLocalCallCount += 1
    }
    
    var updateNumberCalled = false
    var updateNumberCallCount = 0
    func updateNumber(of product: EterationStudyCase.Product, newNumber: Int){
        updateNumberCalled = true
        updateNumberCallCount += 1
    }
    
    var totalPrice: Int = 20
    
    var cartProducts: Set<EterationStudyCase.Product> = []
    
    var addSubscriberCalled = false
    var addSubscriberCallCount = 0
    func addSubscriber(proccess: @escaping EterationStudyCase.Process) {
        addSubscriberCalled = true
        addSubscriberCallCount += 1
    }
    
    var removeSubscriberCalled = false
    var removeSubscriberCallCount = 0
    func removeSubscriber(proccess: @escaping EterationStudyCase.Process) {
        removeSubscriberCalled = true
        removeSubscriberCallCount += 1
    }
    
    var addProductToCartCalled = false
    var addProductToCartCallCount = 0
    func addProductToCart(_ product: EterationStudyCase.Product) {
        addProductToCartCalled = true
        addProductToCartCallCount += 1
    }
}

