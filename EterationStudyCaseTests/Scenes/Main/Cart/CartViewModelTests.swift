//
//  CartViewModelTests.swift
//  EterationStudyCaseTests
//
//  Created by Teyhan Uslu on 19.07.2024.
//

import XCTest
@testable import EterationStudyCase

final class CartViewModelTests: XCTestCase {
    private var viewModel: CartViewModel!
    private var view: MockCartViewController!
    private var cartManager: MockCartManager!
    
    private let exampleProduct = Product(createdAt: nil, name: "product1", image: nil, price: nil, description: nil, model: nil, brand: nil, id: "1")
    
    override func setUp() {
        super.setUp()
        view = .init()
        cartManager = .init()
        viewModel = .init(view: view)
        viewModel.cartManager = cartManager
    }

    func test_viewDidLoad_ () {
        XCTAssertFalse(cartManager.addSubscriberCalled)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(cartManager.addSubscriberCallCount, 1)
    }
    
    func test_viewWillAppear_() {
        XCTAssertEqual(viewModel.itemsCount, 0)
        cartManager.cartProducts = [exampleProduct]
        XCTAssertFalse(view.setTotalPriceCalled)
        XCTAssertFalse(view.reloadCalled)
        
        viewModel.viewWillAppear()
        
        XCTAssertEqual(viewModel.itemsCount, 1)
        XCTAssertEqual(view.setTotalPricePrice, "20.00".tl)
        XCTAssertEqual(view.reloadCallCount, 1)
    }
    
    
    func test_viewWillDisappear_CallsCartManagerSaveToLocalAndRemoveSubscriber() {
        XCTAssertFalse(cartManager.saveToLocalCalled)
        XCTAssertFalse(cartManager.removeSubscriberCalled)
        
        viewModel.viewWillDisappear()
        
        XCTAssertEqual(cartManager.saveToLocalCallCount, 1)
        XCTAssertEqual(cartManager.removeSubscriberCallCount, 1)
    }
    
    func test_itemsCount_Returns3() {
        XCTAssertEqual(viewModel.itemsCount, 0)
        cartManager.cartProducts = [
            .init(createdAt: nil, name: "product1", image: nil, price: nil, description: nil, model: nil, brand: nil, id: "1"),
            .init(createdAt: nil, name: "product2", image: nil, price: nil, description: nil, model: nil, brand: nil, id: "2"),
            .init(createdAt: nil, name: "product3", image: nil, price: nil, description: nil, model: nil, brand: nil, id: "3")
        ]
        
        viewModel.viewWillAppear()
        
        XCTAssertEqual(viewModel.itemsCount, 3)
    }
    
    func test_items_ReturnsSameItem() {
        XCTAssertEqual(viewModel.itemsCount, 0)
        cartManager.cartProducts = [exampleProduct]
        
        viewModel.viewWillAppear()
        
        XCTAssertEqual(viewModel.item(at: 0), exampleProduct)
    }
}
