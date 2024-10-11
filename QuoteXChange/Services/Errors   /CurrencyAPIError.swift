//
//  CurrencyAPIError.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 11.10.24.
//

import Foundation

enum CurrencyAPIError: LocalizedError {
    case invalidURL
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .invalidResponse:
            return "The response from the server is invalid."
        }
    }
}
