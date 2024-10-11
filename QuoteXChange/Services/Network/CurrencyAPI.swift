//
//  CurrencyAPI.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//

import Alamofire
import Foundation

class CurrencyAPI {
    private let baseURL = "https://valyuta.com/api"
    
    // Fetch the list of currencies
    
    func fetchCurrencyList(completion: @escaping (Result<[Currency], Error>) -> Void) {
        let url = URL(string: "\(baseURL)/get_currency_list_for_app")!
        
        AF.request(url)
            .validate()
            .responseDecodable(of: [Currency].self) { response in
                
                switch response.result {
                case .success(let currencies):
                    completion(.success(currencies))
                    
                case .failure(let error):
                    print("Error decoding response: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }



    // Fetch the conversion rate between two currencies
    func fetchCurrencyRate(from: String, to: String, date: String, completion: @escaping (Result<Double, Error>) -> Void) {
        let urlString = "\(baseURL)/get_currency_rate_for_app/\(from)/\(date)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(CurrencyAPIError.invalidURL))
            return
        }

        AF.request(url)
            .validate()
            .responseDecodable(of: CurrencyRate.self) { response in
                       switch response.result {
                       case .success(let currencyRate):
                           print("Currency Rate: \(currencyRate.result)")
                           completion(.success(currencyRate.result))
                       case .failure(let error):
                           print("Error: \(error.localizedDescription)")
                           completion(.failure(error))
                       }
                   }
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    print("Raw JSON Response: \(value)")  // Log the raw JSON to inspect the structure
//                    completion(.failure(CurrencyAPIError.invalidResponse))
//                case .failure(let error):
//                    print("Error: \(error.localizedDescription)")
//                    completion(.failure(error))
//                }
//            }
    }

}








