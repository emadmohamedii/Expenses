//
//  AddExpenseViewModel.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import SwiftUI

@MainActor
final class AddExpenseViewModel: ObservableObject {
    @Published var category: String = "Entertainment"
    @Published var amount: String = ""
    @Published var date: Date = Date()
    @Published var receiptImage: UIImage?
    @Published var receiptFileURL: URL?
    
    @Published var isSaving = false
    @Published var errorMessage: String?
    @Published var saveSuccess = false

    private let repository: ExpenseRepositoryProtocol

    init(repository: ExpenseRepositoryProtocol) {
        self.repository = repository
    }

    func saveExpense() async {
        guard !isSaving else { return } // prevent duplicate calls
        isSaving = true
        defer { isSaving = false }

        errorMessage = nil
        saveSuccess = false
        
        guard let amountValue = Double(amount), amountValue > 0 else {
            errorMessage = "Invalid amount."
            return
        }
        
        do {
            let converted = try await repository.fetchConvertedAmount(
                amount: amountValue,
                currency: "USD" // or use user-selected currency
            )
            
            let newExpense = Expense(
                id: UUID(),
                category: category,
                amount: amountValue,
                currency: "USD",
                date: date,
                receiptImageData: receiptImage?.jpegData(compressionQuality: 0.8),
                convertedAmountUSD: converted
            )

            try await repository.addExpense(newExpense)
            saveSuccess = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
