//
//  MockNetworkManager.swift
//  EterationStudyCaseTests
//
//  Created by Teyhan Uslu on 19.07.2024.
//

@testable import EterationStudyCase

final class MockNetworkManager: NetworkServiceProtocol {
    
    var demoProduct: [Product] =  [
        .init(createdAt: nil, name: "product1", image: nil, price: nil, description: nil, model: nil, brand: "brand1", id: "1"),
        .init(createdAt: nil, name: "product2", image: nil, price: nil, description: nil, model: nil, brand: "brand2", id: "2"),
        .init(createdAt: nil, name: "product3", image: nil, price: nil, description: nil, model: nil, brand: "brand3", id: "3")
    ]
    
    var productsData: [Product] =  []
    
    func get<T>(urlString: String) async throws -> T where T : Decodable {
        return productsData as! T
    }
}
