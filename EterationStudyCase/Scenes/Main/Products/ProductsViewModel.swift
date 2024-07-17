//
//  ProductsViewModel.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 14.07.2024.
//

import Foundation

protocol ProductsViewModelProtocol: AnyObject {
    func viewDidLoad()
    var itemsCount: Int { get }
    func item(at index: Int) -> Product
}


protocol ProductsViewProtocol: AnyObject {
    func reload()
}


class ProductsViewModel {
    var products: Products = [] {
        didSet {
            DispatchQueue.main.async {
                self.view.reload()
            }
        }
    }
    
    unowned var view: ProductsViewProtocol
    
    init(view: ProductsViewProtocol) {
        self.view = view
    }
    
    func fetch() {
        Task {
            do {
                let data: Products = try await NetworkManager.shared.get(urlString: "https://5fc9346b2af77700165ae514.mockapi.io/products")
                print("Data received: \(data)")
                products = data
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

extension ProductsViewModel: ProductsViewModelProtocol {
    func viewDidLoad() {
        fetch()
    }
    
    var itemsCount: Int {
        products.count
    }
    
    func item(at index: Int) -> Product {
        products[index]
    }
}
