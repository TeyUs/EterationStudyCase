//
//  FilterManager.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 18.07.2024.
//

import Foundation

protocol FilterManagerProtocol {
    var allData: [Product] { get set }
    var brandSelected: Set<String>  { get set }
    var modelSelected: Set<String>  { get set }
}

class FilterManager: NSObject, FilterManagerProtocol {
    internal static var shared = FilterManager()
    
    var allData: [Product] = []
    var brandSelected: Set<String> = []
    var modelSelected: Set<String> = []
    
    private override init() {
        super.init()
    }
}
