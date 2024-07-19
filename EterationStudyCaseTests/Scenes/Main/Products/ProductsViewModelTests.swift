//
//  ProductsViewModelTests.swift
//  EterationStudyCaseTests
//
//  Created by Teyhan Uslu on 19.07.2024.
//

import XCTest
@testable import EterationStudyCase

final class ProductsViewModelTests: XCTestCase {
    private var viewModel: ProductsViewModel!
    private var view: MockProductsViewController!
    private var filterManager: MockFilterManager!
    private var service: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        view = .init()
        filterManager = .init()
        service = .init()
        viewModel = .init(view: view, networkService: service)
        viewModel.filterManager = filterManager
    }


    func test_viewDidLoad_itemCountsIs3() async throws {
        var serviceResult: [Product] = try await service.get(urlString: "CorrectUrl")
        XCTAssertFalse(view.reloadCalled)
        XCTAssertEqual(serviceResult, [Product]())
        XCTAssertEqual(viewModel.itemsCount, 0)
        service.productsData = service.demoProduct
        
        viewModel.viewDidLoad()
        
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 sec
        XCTAssertEqual(view.reloadCallCount, 1)
        XCTAssertEqual(viewModel.itemsCount, service.demoProduct.count)
        XCTAssertEqual(viewModel.item(at: 0), service.demoProduct[0])
    }
    
    func test_searchBarTextDidChange_ () async throws {
        var serviceResult: [Product] = try await service.get(urlString: "CorrectUrl")
        XCTAssertFalse(view.reloadCalled)
        XCTAssertEqual(serviceResult, [Product]())
        XCTAssertEqual(viewModel.itemsCount, 0)
        service.productsData = service.demoProduct
        viewModel.viewDidLoad()
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 sec
        XCTAssertEqual(view.reloadCallCount, 1)
        XCTAssertEqual(viewModel.itemsCount, service.demoProduct.count)
        
        viewModel.searchBarTextDidChange(service.demoProduct[0].name ?? "product1")
        
        serviceResult = try await service.get(urlString: "CorrectUrl")
        XCTAssertEqual(serviceResult, service.demoProduct)
        XCTAssertEqual(view.reloadCallCount, 2)
        XCTAssertEqual(viewModel.itemsCount, 1)
        XCTAssertEqual(viewModel.item(at: 0), service.demoProduct[0])
    }
    
    func test_filterPageDissmissed_searchedFilteredProductsDoesntChange() async throws {
        var serviceResult: [Product] = try await service.get(urlString: "CorrectUrl")
        XCTAssertFalse(view.reloadCalled)
        XCTAssertEqual(serviceResult, [Product]())
        XCTAssertEqual(viewModel.itemsCount, 0)
        service.productsData = service.demoProduct
        viewModel.viewDidLoad()
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 sec
        XCTAssertEqual(view.reloadCallCount, 1)
        XCTAssertEqual(viewModel.itemsCount, service.demoProduct.count)
        
        viewModel.filterPageDissmissed()
    
        serviceResult = try await service.get(urlString: "CorrectUrl")
        XCTAssertEqual(serviceResult, service.demoProduct)
        XCTAssertEqual(view.reloadCallCount, 2)
        XCTAssertEqual(viewModel.itemsCount, 3)
        XCTAssertEqual(viewModel.item(at: 0), service.demoProduct[0])
    }
    
    func test_filterPageDissmissed_addedFilter_searchedFilteredProductsFiltered() async throws {
        var serviceResult: [Product] = try await service.get(urlString: "CorrectUrl")
        XCTAssertFalse(view.reloadCalled)
        XCTAssertEqual(serviceResult, [Product]())
        XCTAssertEqual(viewModel.itemsCount, 0)
        service.productsData = service.demoProduct
        viewModel.viewDidLoad()
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 sec
        XCTAssertEqual(view.reloadCallCount, 1)
        XCTAssertEqual(viewModel.itemsCount, service.demoProduct.count)
        let selectedBrand = service.demoProduct[0].brand ?? ""
        filterManager.brandSelected = [selectedBrand]
        
        viewModel.filterPageDissmissed()
        
        XCTAssertEqual(view.reloadCallCount, 2)
        XCTAssertEqual(viewModel.itemsCount, 1)
        XCTAssertEqual(viewModel.item(at: 0).brand, selectedBrand)
    }
    
    func test_selectFilterTapped_addedFilter_searchedFilteredProductsFiltered() async throws {
        var serviceResult: [Product] = try await service.get(urlString: "CorrectUrl")
        XCTAssertFalse(view.reloadCalled)
        XCTAssertEqual(serviceResult, [Product]())
        XCTAssertEqual(viewModel.itemsCount, 0)
        service.productsData = service.demoProduct
        viewModel.viewDidLoad()
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 sec
        XCTAssertEqual(view.reloadCallCount, 1)
        XCTAssertEqual(viewModel.itemsCount, service.demoProduct.count)
        
        viewModel.selectFilterTapped()
        
        XCTAssertEqual(filterManager.allData, service.demoProduct)
    }
    
    func test_itemsCount_Returns0() async throws {
        var serviceResult: [Product] = try await service.get(urlString: "CorrectUrl")
        XCTAssertFalse(view.reloadCalled)
        XCTAssertEqual(serviceResult, [Product]())
        XCTAssertEqual(viewModel.itemsCount, 0)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(viewModel.itemsCount, 0)
    }
    
    func test_itemsCount_fetchCalled_Returns3() async throws {
        var serviceResult: [Product] = try await service.get(urlString: "CorrectUrl")
        XCTAssertFalse(view.reloadCalled)
        XCTAssertEqual(serviceResult, [Product]())
        XCTAssertEqual(viewModel.itemsCount, 0)
        
        service.productsData = service.demoProduct
        viewModel.viewDidLoad()
        
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 sec
        XCTAssertEqual(viewModel.itemsCount, 3)
    }
    
    func test_items_ReturnsSameItem() async throws {
        XCTAssertEqual(viewModel.itemsCount, 0)
        service.productsData = [service.demoProduct[0]]
        
        viewModel.viewDidLoad()
        
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 sec
        XCTAssertEqual(viewModel.item(at: 0), service.demoProduct[0])
    }
}
