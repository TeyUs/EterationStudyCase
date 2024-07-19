//
//  MockCartViewController.swift
//  EterationStudyCaseTests
//
//  Created by Teyhan Uslu on 19.07.2024.
//

@testable import EterationStudyCase

final class MockCartViewController: CartViewControllerProtocol {
    var isReloadCalled = false
    var setTotalPriceCalled = false
    
    func reload() {
        isReloadCalled = true
    }
    
    func setTotalPrice(_ price: String) {
        setTotalPriceCalled = true
    }
}
