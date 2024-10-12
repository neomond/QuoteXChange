//
//  CurrencyAPI.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//

import Foundation

class CurrencyAPI {
    private let baseURL = "https://valyuta.com/api"
    
    /// Fetch the list of currencies
    func fetchCurrencyList(completion: @escaping (Result<[Currency], Error>) -> Void) {
        
        let urlString = "\(baseURL)/get_currency_list_for_app"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(CurrencyAPIError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(CurrencyAPIError.requestFailed(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(CurrencyAPIError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(CurrencyAPIError.invalidResponse))
                return
            }

            // Print raw data for debugging
            print(String(data: data, encoding: .utf8) ?? "No data")

            do {
                let currencies = try JSONDecoder().decode([Currency].self, from: data)
                completion(.success(currencies))
            } catch {
                completion(.failure(CurrencyAPIError.decodingFailed(error)))
            }
        }

        task.resume()
    }

    /// Fetch the conversion rate between two currencies
    func fetchCurrencyRate(from: String, date: String, completion: @escaping (Result<[CurrencyRate], Error>) -> Void) {
        
        let urlString = "\(baseURL)/get_currency_rate_for_app/\(from)/\(date)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(CurrencyAPIError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(CurrencyAPIError.requestFailed(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(CurrencyAPIError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(CurrencyAPIError.invalidResponse))
                return
            }

            /// --------------------- for debugging ---------------------
            print(String(data: data, encoding: .utf8) ?? "No data")

            do {
                let currencyRates = try JSONDecoder().decode([CurrencyRate].self, from: data)
                completion(.success(currencyRates))
            } catch {
                completion(.failure(CurrencyAPIError.decodingFailed(error)))
            }
        }

        task.resume()
    }


}









