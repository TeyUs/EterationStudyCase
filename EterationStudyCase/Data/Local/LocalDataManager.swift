//
//  LocalDataManager.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 16.07.2024.
//

import Foundation
import CoreData

class LocalDataManager {
    
    static let shared = LocalDataManager()
    
    let context = CoreDataStack.shared.context
    private init() {}
    
    func updateOrSaveProduct(product: Product) {
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        
        guard let id = product.id else { return }
        
        let idPredicate = NSPredicate(format: "id == %@", id)
        request.predicate = idPredicate
        
        do {
            let result = try context.fetch(request)
            if let productEntity = result.first {
                if productEntity.numberOfCart != Int32(product.numberOfCart ?? 0) {
                    productEntity.numberOfCart = Int32(product.numberOfCart ?? 0)
                    try context.save()
                }
            } else {
                saveProduct(product: product)
            }
        } catch {
            print("Failed updating: \(error)")
        }
    }
    
    private func saveProduct(product: Product) {
        let productEntity = ProductEntity(context: context)
        
        productEntity.name = product.name
        productEntity.image = product.image
        productEntity.price = product.price
        productEntity.descriptionText = product.description
        productEntity.numberOfCart = Int32(product.numberOfCart ?? 0)
        productEntity.id = product.id
        
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("Failed saving")
        }
    }
    
    func loadProducts() -> [Product] {
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            let products = result.compactMap { entity -> Product? in
                guard let _ = entity.id else {
                    return nil
                }
                return Product(createdAt: nil, name: entity.name, image: entity.image, price: entity.price, description: entity.descriptionText, model: nil, brand: nil, id: entity.id, numberOfCart: Int(entity.numberOfCart))
            }
            return products
        } catch {
            print("Failed loading: \(error)")
            return []
        }
    }
}
