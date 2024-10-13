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
    @Published var amount: String = "" {
        didSet {
            if amount.isEmpty {
                convertedAmount = 0.0
            }
        }
    }
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
        currencyAPI.fetchCurrencyList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.handleFetchCurrencyListResult(result)
            }
        }
    }

    private func handleFetchCurrencyListResult(_ result: Result<[Currency], Error>) {
        switch result {
        case .success(let currencies):
            self.currencyList = currencies
            self.primaryCurrency = currencies.first
            self.secondaryCurrency = currencies.count > 1 ? currencies[1] : nil
        case .failure(let error):
            self.errorWrapper = ErrorWrapper(message: error.localizedDescription)
        }
    }

    /// Fetch the conversion rates and calculate the converted amount
    func convertCurrency() {
        guard let fromCurrency = primaryCurrency?.code,
              let toCurrency = secondaryCurrency?.code,
              let amountValue = Double(amount) else {
            self.errorWrapper = ErrorWrapper(message: "Invalid input or currencies")
            return
        }

        isLoading = true
        currencyAPI.fetchCurrencyRate(from: fromCurrency, date: Date().formattedCurrentDate()) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.handleCurrencyConversionResult(result, amount: amountValue, from: fromCurrency, to: toCurrency)
            }
        }
    }

    private func handleCurrencyConversionResult(_ result: Result<[CurrencyRate], Error>, amount: Double, from: String, to: String) {
        switch result {
        case .success(let rates):
            if let rateInfo = rates.first(where: { $0.from == from && $0.to == to }) {
                self.convertedAmount = rateInfo.result * amount
            } else if let rateInfo = rates.first(where: { $0.from == to && $0.to == from }) {
                self.convertedAmount = amount / rateInfo.result
            } else {
                self.errorWrapper = ErrorWrapper(message: "Conversion rate not found.")
            }
        case .failure(let error):
            self.errorWrapper = ErrorWrapper(message: error.localizedDescription)
        }
    }

    func validateAmountInput(_ input: String) -> String {
        return input.validatedAmountInput()
    }
}











