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
    
    @State private var showingPrimaryPicker = false
    @State private var showingSecondaryPicker = false
    @State private var searchTextPrimary: String = ""
    @State private var searchTextSecondary: String = ""
    
    var body: some View {
        HStack(spacing: 16) {
            
            /// From Currency Picker
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 2)

                    Button(action: {
                        showingPrimaryPicker.toggle()
                    }) {
                        HStack {
                            Text(primaryCurrency?.code ?? "Select Currency")
                                .font(.body)
                                .foregroundColor(.black)
                                .padding(.horizontal)
                        }
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(12)
                    }
                }
            }
            .sheet(isPresented: $showingPrimaryPicker) {
                VStack {
                    Text("Choose Currency to Convert From")
                        .font(.headline)
                        .padding()
                    
                    TextField("Search", text: $searchTextPrimary)
                        .padding(10)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 16)
                    
                    List {
                        ForEach(currencyList.filter { searchTextPrimary.isEmpty || $0.code.contains(searchTextPrimary) || $0.ru.contains(searchTextPrimary) || $0.az.contains(searchTextPrimary) }, id: \.self) { currency in
                            Button(action: {
                                primaryCurrency = currency
                                showingPrimaryPicker = false
                            }) {
                                HStack {
                                    Text("\(currency.code) - ")
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text(currency.ru)
                                        .foregroundColor(.gray)
                                    
                                    Spacer()
                                    Text(currency.az)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            
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
            
            /// To Currency Picker
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 2)

                    Button(action: {
                        showingSecondaryPicker.toggle()
                    }) {
                        HStack {
                            Text(secondaryCurrency?.code ?? "Select Currency")
                                .font(.body)
                                .foregroundColor(.black)
                                .padding(.horizontal)
                        }
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(12)
                    }
                }
                .sheet(isPresented: $showingSecondaryPicker) {
                    VStack {
                        Text("Choose Currency to Convert To")
                            .font(.headline)
                            .padding()
                        
                        TextField("Search", text: $searchTextSecondary)
                            .padding(10)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                            .padding([.leading, .trailing], 16)
                        
                        List {
                            ForEach(currencyList.filter { searchTextSecondary.isEmpty || $0.code.contains(searchTextSecondary) || $0.ru.contains(searchTextSecondary) || $0.az.contains(searchTextSecondary) }, id: \.self) { currency in
                                Button(action: {
                                    secondaryCurrency = currency
                                    showingSecondaryPicker = false
                                }) {
                                    HStack {
                                        Text("\(currency.code) - ")
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text(currency.ru)
                                            .foregroundColor(.gray)
                                        
                                        Spacer()
                                        Text(currency.az)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
    
    /// Swap the primary and secondary currencies
    private func swapCurrencies() {
        let tempCurrency = primaryCurrency
        primaryCurrency = secondaryCurrency
        secondaryCurrency = tempCurrency
    }
}





