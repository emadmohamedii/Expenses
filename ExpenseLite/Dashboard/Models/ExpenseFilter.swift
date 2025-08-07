//
//  ExpenseFilter.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import Foundation

import Foundation

enum ExpenseFilter: CaseIterable, Equatable {
    case thisMonth
    case last7Days
    
    var title: String {
        switch self {
        case .thisMonth:
            return "This Month"
        case .last7Days:
            return "Last 7 Days"
        }
    }

    var dateRange: (start: Date, end: Date)? {
        let calendar = Calendar.current
        let now = Date()

        switch self {
        case .thisMonth:
            guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now)),
                  let startOfNextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth) else {
                return nil
            }
            return (startOfMonth, startOfNextMonth)

        case .last7Days:
            guard let start = calendar.date(byAdding: .day, value: -7, to: now) else {
                return nil
            }
            return (start, now)
        }
    }
}
