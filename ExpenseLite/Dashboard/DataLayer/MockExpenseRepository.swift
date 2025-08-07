//
//  MockExpenseRepository.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import Foundation

final class MockExpenseRepository: ExpenseRepositoryProtocol {
    
    func fetchExpenses(filter: ExpenseFilter, page: Int) async throws -> [Expense] {
        return [
            Expense(
                id: UUID(),
                category: "Groceries",
                amount: 75.25,
                currency: "EUR",
                date: Date().addingTimeInterval(-86400), // 1 day ago
                receiptImageData: nil,
                convertedAmountUSD: 82.77
            ),
            Expense(
                id: UUID(),
                category: "Transport",
                amount: 20.00,
                currency: "EUR",
                date: Date().addingTimeInterval(-3600 * 24 * 3), // 3 days ago
                receiptImageData: nil,
                convertedAmountUSD: 22.00
            ),
            Expense(
                id: UUID(),
                category: "Shopping",
                amount: 150.00,
                currency: "EUR",
                date: Date().addingTimeInterval(-3600 * 24 * 6), // 6 days ago
                receiptImageData: nil,
                convertedAmountUSD: 165.00
            )
        ]
    }
    
    func addExpense(_ expense: Expense) async throws {
        // Simulate success
    }

    func fetchConvertedAmount(amount: Double, currency: String) async throws -> Double {
        return amount * 1.1 // Simulate 10% conversion rate
    }
}
