//
//  RecentExpensesListView.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import SwiftUI

struct RecentExpensesListView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Recent Expenses")
                    .font(.headline)
                if !viewModel.expenses.isEmpty {
                    Spacer()
                    Text("See all")
                        .foregroundColor(.black)
                        .font(.caption)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            if viewModel.expenses.isEmpty && !viewModel.isLoading {
                Text("No recent expenses found.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top)
            }
            
            ScrollView {
                ForEach(viewModel.expenses) { expense in
                    ExpenseRow(expense: expense)
                }
                
                if viewModel.isLoading {
                    ProgressView().padding()
                } else if viewModel.hasMore {
                    Button("Load More") {
                        Task { await viewModel.loadExpenses() }
                    }
                    .padding()
                }
                
                Spacer(minLength: 20)
            }
        }
    }
}


#Preview {
    let mockDashboardViewModel: DashboardViewModel = {
        let vm = DashboardViewModel(repository: MockExpenseRepository())
        vm.totalBalance = 5000
        vm.totalIncome = 8000
        vm.totalExpenses = 3000
        return vm
    }()

    RecentExpensesListView(viewModel: mockDashboardViewModel)
}


struct ExpenseRow: View {
    let expense: Expense

    var body: some View {
        HStack {
            Image(systemName: "cart")
                .frame(width: 20, height: 20)
                .padding()
                .background(Color.gray.opacity(0.1))
                .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(expense.category)
                    .bold()
                Text("Manual")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text("$\(expense.amount, specifier: "%.2f")")
                    .bold()
                Text(expense.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
