//
//  CartTableViewCell.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 15.07.2024.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    var product: Product?
    
    var numberOfProduct = 0 
    
    lazy var cartManager: CartManagerProtocol = {
        return CartManager.shared
    }()
    
    func setUI(product: Product) {
        self.product = product
        titleLabel.text = product.name
        priceLabel.text = product.price?.tl
        numberOfProduct = product.numberOfCart ?? 0
        numberLabel.text = "\(numberOfProduct)"
    }
    
    @IBAction func decreaseTapped(_ sender: Any) {
        if numberOfProduct > 0 {
            numberOfProduct -= 1
        }
        guard let product else { return }
        cartManager.updateNumber(of: product, newNumber: numberOfProduct)
    }
    
    @IBAction func increaseTapped(_ sender: Any) {
        numberOfProduct += 1
        guard let product else { return }
        cartManager.updateNumber(of: product, newNumber: numberOfProduct)
    }
}
