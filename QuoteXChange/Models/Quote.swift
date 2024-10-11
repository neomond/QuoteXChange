//
//  Quote.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//

import Foundation

struct Quote: Identifiable, Codable {
    var id = UUID()              // Unique ID for each quote
    let symbol: String           // Symbol of the asset (e.g., EUR/USD)
    let buyPrice: Double         // Buy price
    let sellPrice: Double        // Sell price
    let spread: Double           // Spread between buy and sell prices
}

extension Quote {
    init?(dictionary: [String: Any]) {
        guard let symbol = dictionary["symbol"] as? String,
              let buyPrice = dictionary["buyPrice"] as? Double,
              let sellPrice = dictionary["sellPrice"] as? Double,
              let spread = dictionary["spread"] as? Double else { return nil }
        
        self.symbol = symbol
        self.buyPrice = buyPrice
        self.sellPrice = sellPrice
        self.spread = spread
    }
}
