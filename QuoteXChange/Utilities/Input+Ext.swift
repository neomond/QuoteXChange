//
//  Input+Ext.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 13.10.24.
//

import Foundation

extension String {
    /// Validates and filters the input for amount to ensure only valid numeric characters are included.
    func validatedAmountInput() -> String {
        let filtered = self.filter { "0123456789.".contains($0) }
        
        let decimalCount = filtered.filter { $0 == "." }.count
        if decimalCount > 1 {
            return String(filtered.prefix { $0 != "." || decimalCount == 1 })
        }
        
        return filtered
    }
}

