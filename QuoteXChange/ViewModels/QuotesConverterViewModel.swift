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
    
    // Fetch the list of currencies from the API using Alamofire
    func fetchCurrencyList() {
        isLoading = true
        print("Loading started")  // Debug log to ensure loading starts

        currencyAPI.fetchCurrencyList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                print("Loading stopped")  // Debug log to ensure loading stops
                
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



    
    // Fetch the conversion rate and calculate the converted amount using Alamofire
    func convertCurrency() {
        guard let fromCurrency = primaryCurrency?.code,
              let toCurrency = secondaryCurrency?.code,
              let amount = Double(amount) else {
            self.errorWrapper = ErrorWrapper(message: "Invalid input or currencies")
            return
        }
        
        let date = getCurrentDate()
        isLoading = true

        currencyAPI.fetchCurrencyRate(from: fromCurrency, to: toCurrency, date: date) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let rate):
                    self.convertedAmount = rate * amount
                    print("Success: \(rate)")
                case .failure(let error):
                    self.errorWrapper = ErrorWrapper(message: error.localizedDescription)
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








