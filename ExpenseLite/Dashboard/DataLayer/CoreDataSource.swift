//
//  CoreDataSource.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import CoreData

final class CoreDataDataSource {
    private let managedObjectContext: NSManagedObjectContext

    var context: NSManagedObjectContext {
        return managedObjectContext
    }
    
    init(managedObjectContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.managedObjectContext = managedObjectContext
    }

    func fetchExpenses(filter: ExpenseFilter, page: Int, limit: Int) throws -> [ExpenseEntity] {
        let request: NSFetchRequest<ExpenseEntity> = ExpenseEntity.fetchRequest()
        if let predicate = predicate(for: filter) {
            request.predicate = predicate
        }
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.fetchOffset = (page - 1) * limit
        request.fetchLimit = limit
        return try context.fetch(request)
    }

    func saveExpense(_ expense: Expense) throws {
        let entity = expense.toCoreDataEntity(in: context)
        context.insert(entity)
        try context.save()
    }

    private func predicate(for filter: ExpenseFilter) -> NSPredicate? {
        guard let range = filter.dateRange else { return nil }
        return NSPredicate(format: "date >= %@ AND date < %@", range.start as NSDate, range.end as NSDate)
    }
}
