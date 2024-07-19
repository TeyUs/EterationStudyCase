//
//  NetworkManager.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 13.07.2024.
//

import Foundation


protocol NetworkServiceProtocol {
    func get<T: Decodable>(urlString: String) async throws -> T
}

class NetworkManager: NetworkServiceProtocol {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    enum NetworkError: Error {
        case badURL
        case requestFailed
        case unknown
    }
    
    func get<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            throw NetworkError.unknown
        }
    }
}
