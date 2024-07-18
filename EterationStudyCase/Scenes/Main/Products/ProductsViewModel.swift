//
//  ProductsViewModel.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 14.07.2024.
//

import Foundation

protocol ProductsViewModelProtocol: AnyObject {
    func viewDidLoad()
    func searchBarTextDidChange(_ text: String)
    func filterPageDissmissed()
    func selectFilterTapped()
    var itemsCount: Int { get }
    func item(at index: Int) -> Product
}

protocol ProductsViewProtocol: AnyObject {
    func reload()
}

class ProductsViewModel {
    var allProducts: Products = []
    
    var filteredProducts: Products = []
    
    var searchedFilteredProducts: Products = [] {
        didSet {
            DispatchQueue.main.async {
                self.view.reload()
            }
        }
    }
    
    var searchText = ""
    
    unowned var view: ProductsViewProtocol
    
    init(view: ProductsViewProtocol) {
        self.view = view
    }
    
    func fetch() {
        Task {
            do {
                let data: Products = try await NetworkManager.shared.get(urlString: "https://5fc9346b2af77700165ae514.mockapi.io/products")
                print("Data received: \(data)")
                allProducts = data
                filterData()
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func filterData() {
        var filteringList = allProducts
        let filterManager = FilterManager.shared
        if !filterManager.brandSelected.isEmpty {
            let selectedBrands = filterManager.brandSelected
            filteringList = filteringList.filter { product in
                guard let brand = product.brand else { return false }
                return selectedBrands.contains(brand)
            }
        }
        if !filterManager.modelSelected.isEmpty {
            let selectedModels = filterManager.modelSelected
            filteringList = filteringList.filter { product in
                guard let brand = product.model else { return false }
                return selectedModels.contains(brand)
            }
        }
        filteredProducts = filteringList
        searchTextFilterData()
    }
    
    func searchTextFilterData() {
        if searchText.isEmpty {
            searchedFilteredProducts = filteredProducts
        } else {
            searchedFilteredProducts = filteredProducts.filter { product in
                guard let name = product.name else { return false }
                return name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

extension ProductsViewModel: ProductsViewModelProtocol {
    func viewDidLoad() {
        fetch()
    }
    
    func searchBarTextDidChange(_ text: String) {
        searchText = text
        searchTextFilterData()
    }
    
    func filterPageDissmissed() {
        filterData()
    }
    
    func selectFilterTapped() {
        FilterManager.shared.allData = allProducts
    }
    
    var itemsCount: Int {
        searchedFilteredProducts.count
    }
    
    func item(at index: Int) -> Product {
        searchedFilteredProducts[index]
    }
}
