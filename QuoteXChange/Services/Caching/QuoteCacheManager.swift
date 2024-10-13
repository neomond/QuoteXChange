//
//  QuoteCacheManager.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 11.10.24.
//

import Foundation

class QuoteCacheManager {
    private let key = "cachedQuotes"
    
    func saveQuotes(_ quotes: [Quote]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(quotes) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func loadQuotes() -> [Quote] {
        if let data = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            if let cachedQuotes = try? decoder.decode([Quote].self, from: data) {
                return cachedQuotes
            }
        }
        return []
    }
}

