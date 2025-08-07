//
//  ExpenseEntity+CoreDataProperties.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//
//

import Foundation
import CoreData


extension ExpenseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseEntity> {
        return NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
    }
    
    @NSManaged public var amountOriginal: Double
    @NSManaged public var amountUSD: Double
    @NSManaged public var category: String?
    @NSManaged public var currency: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var receiptImagePath: Data?
}

extension ExpenseEntity : Identifiable {

}
