//
//  Products.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 13.07.2024.
//

import Foundation

// MARK: - Product
struct Product: Codable, Hashable {
    let createdAt: String?
    let name: String?
    let image: String?
    let price: String?
    let description: String?
    let model: String?
    let brand: String?
    let id: String?
    var numberOfCart: Int? = 0
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
