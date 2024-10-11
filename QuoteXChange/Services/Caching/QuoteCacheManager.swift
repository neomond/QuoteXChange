//
//  QuoteCacheManager.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 11.10.24.
//

import Foundation

class QuoteCacheManager {
    private let cacheKey = "cachedQuotes"
    
    /// here we save the current quotes to UserDefaults
    func saveQuotesToCache(_ quotes: [Quote]) {
        let quotesData = try? JSONEncoder().encode(quotes)
        UserDefaults.standard.set(quotesData, forKey: cacheKey)
    }
    
    /// here we load cached quotes from UserDefaults
    func loadCachedQuotes() -> [Quote]? {
        if let cachedQuotesData = UserDefaults.standard.data(forKey: cacheKey),
           let cachedQuotes = try? JSONDecoder().decode([Quote].self, from: cachedQuotesData) {
            return cachedQuotes
        }
        return nil
    }
}

