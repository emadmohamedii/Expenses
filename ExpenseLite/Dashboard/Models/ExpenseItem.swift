//
//  ExpenseItem.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//
import Foundation

struct Expense: Identifiable {
    let id: UUID
    let category: String
    let amount: Double
    let currency: String
    let date: Date
    let receiptImageData: Data?
    let convertedAmountUSD: Double
}
