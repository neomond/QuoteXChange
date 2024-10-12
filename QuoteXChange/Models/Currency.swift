//
//  Currency.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//

import Foundation

struct Currency: Identifiable, Codable, Hashable {
    var id: String { code }
    let code: String
    let az: String
    let en: String
    let tr: String
    let ru: String
}


struct ErrorWrapper: Identifiable {
    let id = UUID()
    let message: String
}
