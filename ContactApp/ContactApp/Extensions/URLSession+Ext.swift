//
//  CommonExtensions.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 10/12/20.
//

import Foundation

enum IFError: String, Error {
    case invalidUser = "No user fount"
    case unableToComplete
    case invalidResponse
    case invalidData
    case unableToParseJSON
}

extension URLSession {
    func perform<T>(url: URL, responseModel: T.Type, then: @escaping (Result<T, IFError>) -> Void) where T: Decodable {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                then(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                then(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                then(.failure(.invalidData))
                return
            }
            
            do {
                let followers: T = try JSONDecoder().decode(T.self, from: data)
                then(.success(followers))
            } catch let error {
                then(.failure(.unableToParseJSON))
                print(error.localizedDescription, url.absoluteURL)
            }
            
        }.resume()
    }
}
