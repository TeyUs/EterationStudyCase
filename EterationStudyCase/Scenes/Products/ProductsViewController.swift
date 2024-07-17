//
//  ProductsViewController.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 14.07.2024.
//

import UIKit

class ProductsViewController: UIViewController, StoryboardLoadable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var viewModel: ProductsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "E-Market"

        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
        viewModel?.viewDidLoad()
    }
}

extension ProductsViewController: ProductsViewProtocol {
    @MainActor
    func reload() {
        collectionView.reloadData()
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.itemsCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        let item = (viewModel?.item(at: indexPath.row))!
        cell.setupUI(product: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = viewModel?.item(at: indexPath.row) else { return }
        let view = UIStoryboard.loadViewController() as ProductDetailViewController
        view.viewModel = ProductDetailViewModel(view: view, model: model)
        self.show(view, sender: nil)
    }
}
