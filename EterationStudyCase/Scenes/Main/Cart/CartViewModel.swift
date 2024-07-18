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

class CartViewModel {
    var cartProducts: [Product] = []
    
    lazy var cartManager: CartManagerProtocol = {
        return CartManager.shared
    }()
    
    unowned var view: CartViewControllerProtocol
    
    init(view: CartViewControllerProtocol) {
        self.view = view
    }
    
    func getProductsOfCart() {
        cartProducts = Array(cartManager.cartProducts)
    }
    
    func saveProductsOfCart() {
        cartManager.saveToLocal()
    }
    
    func getTotalPrice() {
        view.setTotalPrice("\(cartManager.totalPrice).00".tl)
    }
    
    func dataUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.getProductsOfCart()
            self?.getTotalPrice()
            self?.view.reload()
        }
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
    }
    
    var itemsCount: Int {
        cartProducts.count
    }
    
    func item(at index: Int) -> Product {
        cartProducts[index]
    }
}
