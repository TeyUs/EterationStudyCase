//
//  ProductsViewController.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 14.07.2024.
//

import UIKit

class ProductsViewController: UIViewController, StoryboardLoadable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filterText: String = ""
    var viewModel: ProductsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "E-Market"
        
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
        viewModel?.viewDidLoad()
    }
    
    @IBAction func selectFilter(_ sender: Any) {
        viewModel?.selectFilterTapped()
        let filterViewController = UIStoryboard.loadViewController() as FilterViewController
        let viewModel = FilterViewModel(view: filterViewController)
        viewModel.didDismiss = { [weak self] in
            self?.viewModel?.filterPageDissmissed()
        }
        filterViewController.viewModel = viewModel
        present(filterViewController, animated: true)
    }
}

extension ProductsViewController: ProductsViewProtocol {
    @MainActor
    func reload() {
        collectionView.reloadData()
    }
}

extension ProductsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchBarTextDidChange(searchText)
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
