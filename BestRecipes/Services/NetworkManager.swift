//
//  NetworkManager.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import Foundation

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case badResponse(statusCode: Int)
    case decodingError(Error)
    case noData
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        return URLSession(configuration: config)
    }()
    
    func fetch<T: Decodable>(_ type: T.Type, from urlString: String) async throws -> T {
        print("NetworkManager urlString:", urlString)
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.badResponse(statusCode: -1)
            }
            print("Status code:", httpResponse.statusCode)
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("NetworkManager Decoding error:", error)
                throw NetworkError.decodingError(error)
            }
        } catch {
            if let urlError = error as? URLError {
                print("URLSession error:", urlError.code)
                throw NetworkError.requestFailed(urlError)
            }
            throw NetworkError.requestFailed(error)
        }
    }
    
    func fetchImage(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        
        return data
    }
}
