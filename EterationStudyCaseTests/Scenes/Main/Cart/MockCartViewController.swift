//
//  MockCartViewController.swift
//  EterationStudyCaseTests
//
//  Created by Teyhan Uslu on 19.07.2024.
//

@testable import EterationStudyCase

final class MockCartViewController: CartViewControllerProtocol {
    
    var reloadCalled = false
    var reloadCallCount = 0
    func reload() {
        reloadCalled = true
        reloadCallCount += 1
    }
    
    
    var setTotalPriceCalled = false
    var setTotalPriceCallCount = 0
    var setTotalPricePrice = ""
    func setTotalPrice(_ price: String) {
        setTotalPriceCalled = true
        setTotalPriceCallCount += 1
        setTotalPricePrice = price
    }
}
