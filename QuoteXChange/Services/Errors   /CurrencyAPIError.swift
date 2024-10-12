//
//  CurrencyAPIError.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 11.10.24.
//

import Foundation

enum CurrencyAPIError: LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .invalidResponse:
            return "The response from the server is invalid."
        case .requestFailed:
            return "The request failed."
        case .decodingFailed(_):
            return "Decoding failed"
        }
    }
}
