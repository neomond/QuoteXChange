//
//  QuotesConverterViewModel.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//

import Foundation

class QuotesConverterViewModel: ObservableObject {
    @Published var primaryCurrency: Currency?
    @Published var secondaryCurrency: Currency?
    @Published var amount: String = ""
    @Published var convertedAmount: Double = 0.0
    @Published var currencyList: [Currency] = []
    @Published var isLoading = false
    @Published var errorWrapper: ErrorWrapper?

    private let currencyAPI = CurrencyAPI()
    
    init() {
        fetchCurrencyList()
    }
    
    /// Fetch the list of currencies from the API
    func fetchCurrencyList() {
        isLoading = true
        print("Loading started")

        currencyAPI.fetchCurrencyList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                print("Loading stopped")
                
                switch result {
                case .success(let currencies):
                    print("Currencies fetched successfully")
                    
                    self?.currencyList = currencies
                    if let firstCurrency = currencies.first {
                        self?.primaryCurrency = firstCurrency
                    }
                    if currencies.count > 1 {
                        self?.secondaryCurrency = currencies[1]
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    
                    self?.errorWrapper = ErrorWrapper(message: error.localizedDescription)
                }
            }
        }
    }

    /// Fetch the conversion rates and calculate the converted amount
    func convertCurrency() {
        guard let fromCurrency = primaryCurrency?.code,
              let toCurrency = secondaryCurrency?.code,
              let amount = Double(amount) else {
            self.errorWrapper = ErrorWrapper(message: "Invalid input or currencies")
            return
        }
        
        let date = getCurrentDate() /// Get current date in "yyyy-MM-dd" format
        isLoading = true

        currencyAPI.fetchCurrencyRate(from: fromCurrency, date: date) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let rates):
                    /// Try to find the rate for the selected currencies in both directions
                    if let rateInfo = rates.first(where: { $0.from == fromCurrency && $0.to == toCurrency }) {
                        self?.convertedAmount = rateInfo.result * amount
                        print("Success: \(rateInfo.result)")
                        
                    } else if let rateInfo = rates.first(where: { $0.from == toCurrency && $0.to == fromCurrency }) {
                        /// If no direct rate found, try the reverse conversion
                        self?.convertedAmount = amount / rateInfo.result /// Inverse the rate
                        print("Success (inverted): \(1 / rateInfo.result)")
                    } else {
                        self?.errorWrapper = ErrorWrapper(message: "Conversion rate not found.")
                        print("Conversion rate not found for \(fromCurrency) to \(toCurrency)")
                    }
                case .failure(let error):
                    self?.errorWrapper = ErrorWrapper(message: error.localizedDescription)
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }

    
    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    func validateAmountInput(_ input: String) -> String {
        let filtered = input.filter { "0123456789.".contains($0) }
        
        let decimalCount = filtered.filter { $0 == "." }.count
        if decimalCount > 1 {
            return String(filtered.prefix { $0 != "." || decimalCount == 1 })
        }
        
        return filtered
    }
}









