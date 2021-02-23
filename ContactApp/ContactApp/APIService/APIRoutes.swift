//
//  APIRoutes.swift
//  ContactApp
//
//  Created by Bibin Jaimon on 12/12/20.
//

import Foundation

enum HTTPSMethod {
    case post
    case get
}

protocol Routable {
    var baseURL: String { get }
    var endpoint: String { get }
    var method: HTTPSMethod { get }
}

extension Routable {
    // default value would go here
    var baseURL: String {
        return "https://shielded-ridge-19050.herokuapp.com/api/"
    }
}

enum APIRoutes: Routable {
    case loadContacts(Int)
    
    var method: HTTPSMethod {
        switch self {
        case .loadContacts:
            return .get
        }
    }
    
    var endpoint: String {
        switch self {
        case .loadContacts(let offset):
            return "\(baseURL)?offset=\(offset)"
        }
    }
}
