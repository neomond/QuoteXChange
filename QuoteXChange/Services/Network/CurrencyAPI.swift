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
        fetchData(urlString: urlString) { (result: Result<[Currency], Error>) in
            completion(result)
        }
    }

    /// Fetch the conversion rate between two currencies
    func fetchCurrencyRate(from: String, date: String, completion: @escaping (Result<[CurrencyRate], Error>) -> Void) {
        let urlString = "\(baseURL)/get_currency_rate_for_app/\(from)/\(date)"
        fetchData(urlString: urlString) { (result: Result<[CurrencyRate], Error>) in
            completion(result)
        }
    }

    /// Generic function to fetch data from a given URL string
    private func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
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

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(CurrencyAPIError.decodingFailed(error)))
            }
        }

        task.resume()
    }
}










