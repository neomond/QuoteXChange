//
//  QuotesConverterView.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//

import SwiftUI

struct QuotesConverterView: View {
    @ObservedObject var viewModel: QuotesConverterViewModel
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if viewModel.isLoading {
                        ProgressView("Loading currencies...")
                            .padding()
                    } else {
                        VStack(alignment: .leading) {
                            Text("Enter Amount")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.leading)
                            
                            TextField("Amount", text: $viewModel.amount)
                                .keyboardType(.decimalPad)
                                .focused($isTextFieldFocused)
                                .onChange(of: viewModel.amount) { newValue in
                                    viewModel.amount = viewModel.validateAmountInput(newValue)
                                }
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                                .shadow(radius: 1)
                                .padding(.horizontal)
                        }
                        .padding(.top, 40)
                        
                        HStack {
                            CurrencyPickersView(
                                primaryCurrency: $viewModel.primaryCurrency,
                                secondaryCurrency: $viewModel.secondaryCurrency,
                                currencyList: viewModel.currencyList
                            )
                            .frame(height: 60)
                        }
                        
                        VStack {
                            Text("Converted Amount")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.bottom, 4)
                            
                            Text("\(viewModel.convertedAmount, specifier: "%.4f")")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 2)
                                .padding(.horizontal)
                        }
                        
                        Button(action: {
                            viewModel.convertCurrency()
                        }) {
                            Text("Convert")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .shadow(radius: 2)
                        }
                        .padding(.horizontal)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    isTextFieldFocused = false
                }
                .navigationTitle("Currency Converter")
                .alert(item: $viewModel.errorWrapper) { error in
                    Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}





