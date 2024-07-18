//
//  FilterModel.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 17.07.2024.
//

import Foundation

struct FilterModel: Hashable, Comparable {
    let name: String
    var isChecked: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: FilterModel, rhs: FilterModel) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func < (lhs: FilterModel, rhs: FilterModel) -> Bool {
        lhs.name < rhs.name
    }
}
