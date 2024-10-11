//
//  CurrencyRate.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//

import Foundation

struct CurrencyRate: Codable {
    var from: String
    let to: String
    let result: Double
    let date: String
    let menbe: String
}
