//
//  APIEnvironment.swift
//  NetworkLayer
//
//  Created by Gaurav Chauhan on 15/12/22.
//

import Foundation

enum APIEnvironment {
    case development
    case staging
    case production
    
    func baseURL () -> String {
        return "https://\(subdomain()).\(domain())"
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return "unsplash.com"
        case .staging:
            return "unsplash.com"
        case .production:
            return "unsplash.com"
        }
    }
    
    func subdomain() -> String {
        switch self {
        case .development, .production, .staging:
            return "api"
        }
    }
    
    func route() -> String {
        return "/api/v1"
    }
}
