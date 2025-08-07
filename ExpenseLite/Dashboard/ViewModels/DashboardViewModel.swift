//
//  DashboardViewModel.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import SwiftUI

@MainActor
final class DashboardViewModel: ObservableObject {
    
    // MARK: - UI State
    @Published var expenses: [Expense] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedFilter: ExpenseFilter = .thisMonth
    @Published var currentPage: Int = 1
    @Published var hasMore: Bool = true
    
    // MARK: - Summary
    @Published var totalBalance: Double = 0.0
    @Published var totalIncome: Double = 0.0
    @Published var totalExpenses: Double = 0.0
    
    // MARK: - Dependencies
    private let repository: ExpenseRepositoryProtocol
    
    // MARK: - Init
    init(repository: ExpenseRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Load Expenses (initial or paged)
    func loadExpenses(reset: Bool = false) async {
        if isLoading || (!hasMore && !reset) { return }

        isLoading = true
        errorMessage = nil

        if reset {
            currentPage = 1
            hasMore = true
            expenses = []
        }

        do {
            let result = try await repository.fetchExpenses(filter: selectedFilter, page: currentPage)
            if result.isEmpty {
                hasMore = false
            } else {
                expenses.append(contentsOf: result)
                currentPage += 1
                computeSummary()
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: - Update on Filter Change
    func updateFilter(_ filter: ExpenseFilter) async {
        selectedFilter = filter
        await loadExpenses(reset: true)
    }
    
    // MARK: - Balance Calculation
    private func computeSummary() {
        totalExpenses = expenses.reduce(0) { $0 + $1.amount }
        totalIncome = totalExpenses * 6.0 
        totalBalance = totalIncome - totalExpenses
    }
}
