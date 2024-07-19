//
//  MockFilterManager.swift
//  EterationStudyCaseTests
//
//  Created by Teyhan Uslu on 19.07.2024.
//

@testable import EterationStudyCase

final class MockFilterManager: FilterManagerProtocol {
    
    var allData: [EterationStudyCase.Product] = []
    
    var brandSelected: Set<String> = []
    
    var modelSelected: Set<String> = []
}
