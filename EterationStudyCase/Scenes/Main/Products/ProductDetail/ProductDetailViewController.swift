//
//  ProductDetailViewController.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 15.07.2024.
//

import UIKit

class ProductDetailViewController: UIViewController, StoryboardLoadable {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var viewModel: ProductDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
    
    @IBAction func favButtonTapped(_ sender: Any) {
        //TODO: favorite button feature will be added
    }
    
    @IBAction func AddCartTapped(_ sender: Any) {
        viewModel?.addCartTapped()
    }
}

extension ProductDetailViewController: ProductDetailViewProtocol {
    func setImage(_ text: String) {
        if let url = URL(string: text) {
            productImage.kf.setImage(with: url)
        }
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
        self.title = text
    }
    
    func setDescription(_ text: String) {
        descriptionLabel.text = text
    }
    
    func setPrice(_ text: String) {
        priceLabel.text = text
    }
}

