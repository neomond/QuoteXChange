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
                    
                    HStack {
                        CurrencyPickersView(
                            primaryCurrency: $viewModel.primaryCurrency,
                            secondaryCurrency: $viewModel.secondaryCurrency,
                            currencyList: viewModel.currencyList
                        )
                        .frame(height: 60)
                    }
                    
                    Spacer().frame(height: 20)
                    
                    VStack {
                        Text("Converted Amount")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 4)
                        Text("\(viewModel.convertedAmount, specifier: "%.2f")")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                    }
                    
                    Spacer().frame(height: 20)
                    
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
            .navigationTitle("Currency Converter")
            .alert(item: $viewModel.errorWrapper) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}


struct QuotesConverterView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = QuotesConverterViewModel()
        
        // Pre-fill the mock view model with data
        mockViewModel.primaryCurrency = Currency(code: "USD", az: "Dollar", en: "Dollar", tr: "Dolar", ru: "Доллар")
        mockViewModel.secondaryCurrency = Currency(code: "EUR", az: "Euro", en: "Euro", tr: "Euro", ru: "Евро")
        mockViewModel.amount = "100"
        mockViewModel.convertedAmount = 85.75
        mockViewModel.currencyList = [
            Currency(code: "USD", az: "Dollar", en: "Dollar", tr: "Dolar", ru: "Доллар"),
            Currency(code: "EUR", az: "Euro", en: "Euro", tr: "Euro", ru: "Евро"),
            Currency(code: "GBP", az: "Pound", en: "Pound", tr: "Pound", ru: "Фунт")
        ]
        
        return QuotesConverterView(viewModel: mockViewModel)
    }
}


