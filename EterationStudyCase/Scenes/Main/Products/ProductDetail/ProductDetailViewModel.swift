//
//  ProductDetailViewModel.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 15.07.2024.
//

import Foundation

protocol ProductDetailViewModelProtocol: AnyObject {
    func viewDidLoad()
    func addCartTapped()
}

protocol ProductDetailViewProtocol: AnyObject {
    func setImage(_ text: String)
    func setTitle(_ text: String)
    func setDescription(_ text: String)
    func setPrice(_ text: String)
}

class ProductDetailViewModel {
    let model: Product
    
    lazy var cartManager: CartManagerProtocol = {
        return CartManager.shared
    }()
    
    unowned var view: ProductDetailViewProtocol
    
    init(view: ProductDetailViewProtocol, model: Product) {
        self.view = view
        self.model = model
    }
    
    func setUI() {
        view.setImage(model.image ?? "")
        view.setTitle(model.name ?? "")
        view.setDescription(model.description ?? "")
        view.setPrice(model.price ?? "")
    }
}

extension ProductDetailViewModel: ProductDetailViewModelProtocol {
    func viewDidLoad() {
        setUI()
    }
    
    func addCartTapped() {
        cartManager.addProductToCart(model)
    }
}
    
