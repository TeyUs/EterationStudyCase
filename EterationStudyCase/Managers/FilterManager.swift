//
//  FilterManager.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 18.07.2024.
//

import Foundation

class FilterManager: NSObject {
    internal static var shared = FilterManager()
    
    var allData: [Product] = []
    var brandSelected: Set<String> = []
    var modelSelected: Set<String> = []
    
    var filteredData: [Product] = []
    
    private override init() {
        super.init()
    }
}
