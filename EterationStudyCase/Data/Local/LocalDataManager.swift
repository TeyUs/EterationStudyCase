//
//  DataManager.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 16.07.2024.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    func saveItem(name: DataManagerItemName) {
        let context = CoreDataStack.shared.context
        let entity = NSEntityDescription.entity(forEntityName: name.rawValue, in: context)!
        let newItem = NSManagedObject(entity: entity, insertInto: context)
        
        newItem.setValue(name, forKey: "name")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}

enum DataManagerItemName: String {
    case cart = "Cart"
}


