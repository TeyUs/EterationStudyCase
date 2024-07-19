//
//  MockProductsViewController.swift
//  EterationStudyCaseTests
//
//  Created by Teyhan Uslu on 19.07.2024.
//

@testable import EterationStudyCase

final class MockProductsViewController: ProductsViewProtocol {
    var reloadCalled = false
    var reloadCallCount = 0
    func reload() {
        reloadCalled = true
        reloadCallCount += 1
    }
}
