//
//  CurrencyService.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import Foundation

protocol CurrencyService {
    func convert(amount: Double, from: String, to: String) async throws -> Double
}

final class RealCurrencyService: CurrencyService {
    
    func convert(amount: Double, from: String, to: String) async throws -> Double {
        let urlString = "https://open.er-api.com/v6/latest/\(from)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(CurrencyResponse.self, from: data)
        
        guard decoded.result == "success" else {
            throw NSError(domain: "CurrencyConversion", code: 1, userInfo: [NSLocalizedDescriptionKey: "API failed"])
        }
        
        guard let rate = decoded.rates[to] else {
            throw NSError(domain: "CurrencyConversion", code: 2, userInfo: [NSLocalizedDescriptionKey: "Rate for \(to) not found"])
        }
        
        return amount * rate
    }
}
