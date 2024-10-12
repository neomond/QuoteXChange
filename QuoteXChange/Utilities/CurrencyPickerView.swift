//
//  CurrencyPickerView.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 11.10.24.
//

import SwiftUI

struct CurrencyPickersView: View {
    @Binding var primaryCurrency: Currency?
    @Binding var secondaryCurrency: Currency?
    let currencyList: [Currency]
    
    var body: some View {
        HStack(spacing: 16) {
            
            // From Currency Picker
            VStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                    Picker("From", selection: $primaryCurrency) {
                        ForEach(currencyList, id: \.self) { currency in
                            Text("\(currency.code) ")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .tag(currency as Currency?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(12)
                   
                }
            }
            
            // Swap Icon
            Button(action: {
                swapCurrencies()
            }) {
                Image(systemName: "arrow.left.arrow.right")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(8)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
            }
            
            // To Currency Picker
            VStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                    Picker("To", selection: $secondaryCurrency) {
                        ForEach(currencyList, id: \.self) { currency in
                            Text("\(currency.code)")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.black) 
                                .tag(currency as Currency?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(12)
                    .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal)
    }
    
    // Swap the primary and secondary currencies
    private func swapCurrencies() {
        let tempCurrency = primaryCurrency
            primaryCurrency = secondaryCurrency
            secondaryCurrency = tempCurrency
       
    }
}



