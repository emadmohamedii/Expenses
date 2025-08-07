//
//  AddExpenseViewModelTests.swift
//  ExpenseLiteTests
//
//  Created by Emad Habib on 08/08/2025.
//

import XCTest
@testable import ExpenseLite

@MainActor
final class AddExpenseViewModelTests: XCTestCase {

    // Mock Repository
    final class MockExpenseRepository: ExpenseRepositoryProtocol {
        var didAddExpense = false
        func fetchExpenses(filter: ExpenseFilter, page: Int) async throws -> [Expense] {
            return []
        }

        func addExpense(_ expense: Expense) async throws {
            didAddExpense = true
        }

        func fetchConvertedAmount(amount: Double, currency: String) async throws -> Double {
            return amount * 1.1
        }
    }

    func testInvalidAmount_shouldSetErrorMessage() async {
        let repo = MockExpenseRepository()
        let viewModel = AddExpenseViewModel(repository: repo)
        viewModel.amount = "-100"

        await viewModel.saveExpense()

        XCTAssertEqual(viewModel.errorMessage, "Invalid amount.")
        XCTAssertFalse(viewModel.saveSuccess)
    }

    func testValidAmount_shouldConvertAndSaveSuccessfully() async {
        let repo = MockExpenseRepository()
        let viewModel = AddExpenseViewModel(repository: repo)
        viewModel.amount = "100"
        viewModel.category = "Groceries"
        
        await viewModel.saveExpense()

        XCTAssertNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.saveSuccess)
        XCTAssertTrue(repo.didAddExpense)
    }

    func testCurrencyConversionAccuracy() async throws {
        let repo = MockExpenseRepository()
        let amount: Double = 200
        let result = try await repo.fetchConvertedAmount(amount: amount, currency: "EUR")

        XCTAssertEqual(result, 220, accuracy: 0.001)
    }
}
