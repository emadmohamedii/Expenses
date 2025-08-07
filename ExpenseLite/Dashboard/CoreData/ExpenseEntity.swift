//
//  ExpenseEntity.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//
import Foundation
import CoreData

extension ExpenseEntity {
    func toDomainModel() -> Expense {
        return Expense(
            id: id ?? UUID(),
            category: category ?? "",
            amount: amountOriginal,
            currency: currency ?? "USD",
            date: date ?? Date(),
            receiptImageData: receiptImagePath,
            convertedAmountUSD: amountUSD
        )
    }
}

extension Expense {
    func toCoreDataEntity(in context: NSManagedObjectContext) -> ExpenseEntity {
        let entity = ExpenseEntity(context: context)
        entity.id = self.id
        entity.category = self.category
        entity.amountOriginal = self.amount
        entity.currency = self.currency
        entity.date = self.date
        entity.receiptImagePath = self.receiptImageData
        entity.amountUSD = self.convertedAmountUSD
        return entity
    }
}
