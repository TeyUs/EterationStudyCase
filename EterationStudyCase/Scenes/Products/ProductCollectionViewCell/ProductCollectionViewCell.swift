//
//  ProductCollectionViewCell.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 13.07.2024.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow()
    }
    
    private func setupShadow() {
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        contentView.layer.shadowOpacity = 1.0
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4.0
        contentView.layer.masksToBounds = false
    }
    
    @IBAction func favButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addToCartTapped(_ sender: Any) {
        CartManager.shared.addProductToCart(product)
    }
    
    func setupUI(product: Product) {
        self.product = product
        priceLabel.text = product.price?.tl
        nameLabel.text = product.name
        if let url = URL(string: product.image!) {
            productImage.kf.setImage(with: url)
        }
    }
}
