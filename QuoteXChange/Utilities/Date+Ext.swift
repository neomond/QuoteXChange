//
//  Date+Ext.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 11.10.24.
//

import Foundation

extension Date {
    
    // Default format: "yyyy-MM-dd"
        func formatted() -> String {
            return formatted(with: "yyyy-MM-dd")
        }
        
        // Custom format function
        func formatted(with format: String) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter.string(from: self)
        }
        
        // Example for formatting to a specific time format
        func formattedTime() -> String {
            return formatted(with: "HH:mm:ss")
        }
}
