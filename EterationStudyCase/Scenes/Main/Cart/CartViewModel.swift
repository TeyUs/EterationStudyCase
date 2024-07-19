//
//  CartViewModel.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 15.07.2024.
//

import Foundation

protocol CartViewModelProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    var itemsCount: Int { get }
    func item(at index: Int) -> Product
}

protocol CartViewControllerProtocol: AnyObject {
    func reload()
    func setTotalPrice(_ price: String)
} 

final class CartViewModel {
    private var cartProducts: [Product] = []
    
    lazy var cartManager: CartManagerProtocol = {
        return CartManager.shared
    }()
    
    private unowned var view: CartViewControllerProtocol
    
    init(view: CartViewControllerProtocol) {
        self.view = view
    }
    
    private func getProductsOfCart() {
        cartProducts = Array(cartManager.cartProducts)
    }
    
    private func saveProductsOfCart() {
        cartManager.saveToLocal()
    }
    
    private func getTotalPrice() {
        view.setTotalPrice("\(cartManager.totalPrice).00".tl)
    }
    
    private func dataUpdated() {
        getProductsOfCart()
        getTotalPrice()
        view.reload()
    }
}

extension CartViewModel: CartViewModelProtocol {
    func viewDidLoad() {
        cartManager.addSubscriber { [weak self] in
            self?.dataUpdated()
        }
    }
    
    func viewWillAppear() {
        dataUpdated()
    }
    
    func viewWillDisappear() {
        saveProductsOfCart()
        cartManager.removeSubscriber { [weak self] in
            self?.dataUpdated()
        }
    }
    
    var itemsCount: Int {
        cartProducts.count
    }
    
    func item(at index: Int) -> Product {
        cartProducts[index]
    }
}
