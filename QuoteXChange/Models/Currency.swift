//
//  Currency.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//

import Foundation

// Define the Currency model that matches the API response structure
struct Currency: Identifiable, Codable, Hashable {
    var id: String { code }  // Use 'code' as the unique identifier
    let code: String          // Currency code (e.g., "USD", "EUR")
    let az: String?           // Name in Azerbaijani (optional in case it can be null)
    let en: String?           // Name in English (optional)
    let tr: String?           // Name in Turkish (optional)
    let ru: String?           // Name in Russian (optional)
}


struct ErrorWrapper: Identifiable {
    let id = UUID()         // Unique ID for each error
    let message: String     // Error message to display
}
