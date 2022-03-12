//
//  APIError.swift
//  
//
//  Created by Ezequiel Becerra on 12/03/2022.
//

import Foundation

public enum APIError: Error {
    case badURL
    case noResponse
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return "URL has an invalid format"

        case .noResponse:
            return "Received no response from server"
        }
    }
}
