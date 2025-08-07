//
//  CurrencyResponse.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

struct CurrencyResponse: Decodable {
    let result: String
    let base_code: String
    let rates: [String: Double]
}
