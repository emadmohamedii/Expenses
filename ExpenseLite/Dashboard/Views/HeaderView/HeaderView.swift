//
//  HeaderView.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("header-background")
                .resizable()
                .frame(height: 300)
                .clipped()
                .cornerRadius(12)
                .ignoresSafeArea(edges: .top)
            
            VStack(spacing: 16) {
                GreetingView(selectedFilter: $viewModel.selectedFilter)
                BalanceCardView(
                    total: viewModel.totalBalance,
                    income: viewModel.totalIncome,
                    expenses: viewModel.totalExpenses
                )
            }
        }
        .frame(height: 300)
    }
}

#Preview {
    HeaderView(viewModel: .init(repository: MockExpenseRepository()))
}
