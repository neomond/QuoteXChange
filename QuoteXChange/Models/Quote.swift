//
//  Quote.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//

import Foundation

struct Quote: Identifiable, Codable {
    var id = UUID()
    let symbol: String
    let buyPrice: Double
    let sellPrice: Double
    let spread: Double
    
    init(symbol: String, buyPrice: Double, sellPrice: Double, spread: Double) {
        self.symbol = symbol
        self.buyPrice = buyPrice
        self.sellPrice = sellPrice
        self.spread = spread
    }
    
    init?(dictionary: [String: Any]) {
        guard let symbol = dictionary["symbol"] as? String,
              let buyPrice = dictionary["buyPrice"] as? Double,
              let sellPrice = dictionary["sellPrice"] as? Double,
              let spread = dictionary["spread"] as? Double else {
            return nil
        }
        
        self.symbol = symbol
        self.buyPrice = buyPrice
        self.sellPrice = sellPrice
        self.spread = spread
    }
}
