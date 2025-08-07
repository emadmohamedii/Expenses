//
//  ExpenseRepository.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

protocol ExpenseRepositoryProtocol {
    func fetchExpenses(filter: ExpenseFilter, page: Int) async throws -> [Expense]
    func addExpense(_ expense: Expense) async throws
    func fetchConvertedAmount(amount: Double, currency: String) async throws -> Double
}

final class ExpenseRepository: ExpenseRepositoryProtocol {
    let local: CoreDataDataSource
    let remote: CurrencyService

    init(local: CoreDataDataSource, remote: CurrencyService) {
        self.local = local
        self.remote = remote
    }
    
    func fetchExpenses(filter: ExpenseFilter, page: Int) async throws -> [Expense] {
        let entities = try local.fetchExpenses(filter: filter, page: page, limit: 5)
        return entities.map { $0.toDomainModel() }
    }
    
    func addExpense(_ expense: Expense) async throws {
        try local.saveExpense(expense)
    }
    
    func fetchConvertedAmount(amount: Double, currency: String) async throws -> Double {
        return try await remote.convert(amount: amount, from: currency, to: "USD")
    }
}
