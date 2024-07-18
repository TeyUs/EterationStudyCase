//
//  FilterViewModel.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 17.07.2024.
//

import Foundation

protocol FilterViewModelProtocol: AnyObject {
    func viewDidLoad()
    func viewWillDisappear()
    func sortButtonsTapped(tag: Int)
    func finisFilterTapped()
    
    var brand: InnerFilterViewModelProtocol { get }
    var model: InnerFilterViewModelProtocol { get }
}

protocol InnerFilterViewModelProtocol {
    var itemsCount: Int { get }
    func item(at index: Int) -> FilterModel
    func selectedRow(at index: Int)
    func saveSelected()
    
}

protocol FilterViewControllerProtocol: AnyObject {
    func reload()
}

class FilterViewModel {
    unowned var view: FilterViewControllerProtocol
    
    var sortBy: FilterSortBy = .newToOld
    
    var brand: InnerFilterViewModelProtocol = Brand()
    var model: InnerFilterViewModelProtocol = Model()
    
    var didDismiss: (() -> ())?
    
    init(view: FilterViewControllerProtocol) {
        self.view = view
    }
}


extension FilterViewModel: FilterViewModelProtocol {
    func viewDidLoad() {
        view.reload()
    }
    
    func viewWillDisappear() {
        didDismiss?()
    }
    
    func sortButtonsTapped(tag: Int) {
        sortBy = FilterSortBy(rawValue: tag) ?? .oldToNew
    }
    
    func finisFilterTapped() {
        brand.saveSelected()
        model.saveSelected()
    }
}


enum FilterSortBy: Int {
    case oldToNew
    case newToOld
    case priceHightToLow
    case priceLowToHigh
}

class InnerFilterViewModel: InnerFilterViewModelProtocol {
    var array: [FilterModel] = []
    var selecteds: Set<String> = []
    
    fileprivate init() {
        loadArray()
    }
    
    var itemsCount: Int {
        array.count
    }

    func item(at index: Int) -> FilterModel {
        array[index]
    }
    
    func selectedRow(at index: Int) {
        let item = item(at: index)
        var result = false
        if selecteds.contains(item.name) {
            selecteds.remove(item.name)
        } else {
            selecteds.insert(item.name)
            result = true
        }
        array[index] = .init(name: item.name, isChecked: result)
    }
    
    func saveSelected() {}
    func loadArray() { }
}

class Brand: InnerFilterViewModel {
    override func saveSelected() {
        FilterManager.shared.brandSelected = selecteds
    }
    
    override func loadArray() {
        selecteds = FilterManager.shared.brandSelected
        let allData = FilterManager.shared.allData
        array = Set(allData.compactMap{ $0.brand })
            .map{FilterModel(name: $0, isChecked: selecteds.contains($0)) }
        array.sort()
    }
}

class Model: InnerFilterViewModel {
    override func saveSelected() {
        FilterManager.shared.modelSelected = selecteds
    }
    
    override func loadArray() {
        selecteds = FilterManager.shared.modelSelected
        let allData = FilterManager.shared.allData
        array = Set(allData.compactMap{ $0.model })
            .map{FilterModel(name: $0, isChecked: selecteds.contains($0)) }
        array.sort()
    }
}
