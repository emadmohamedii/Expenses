//
//  DashboardView.swift
//  ExpenseLite
//
//  Created by Emad Habib on 06/08/2025.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel: DashboardViewModel
    @Binding var refreshTrigger: UUID
    
    init(refreshTrigger: Binding<UUID>) {
        _refreshTrigger = refreshTrigger
        let local = CoreDataDataSource()
        let currencyService = RealCurrencyService()
        let repo = ExpenseRepository(local: local, remote: currencyService)
        _viewModel = StateObject(wrappedValue: DashboardViewModel(repository: repo))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(viewModel: viewModel)
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading expenses...")
                        .padding()
                    Spacer()
                } else {
                    RecentExpensesListView(viewModel: viewModel)
                    Spacer()
                }
            }
            .onAppear {
                Task { await viewModel.loadExpenses(reset: true) }
            }
            .onChange(of: refreshTrigger) { _ in
                Task { await viewModel.loadExpenses(reset: true) }
            }
            .refreshable {
                Task { await viewModel.loadExpenses(reset: true) }
            }
            .onChange(of: viewModel.selectedFilter) { _ in
                Task { await viewModel.loadExpenses(reset: true) }
            }
        }
    }
}

#Preview {
    DashboardView(refreshTrigger: .constant(UUID()))
}
