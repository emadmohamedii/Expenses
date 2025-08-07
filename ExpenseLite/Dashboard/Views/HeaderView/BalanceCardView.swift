//
//  BalanceCardView.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import SwiftUI

struct BalanceCardView: View {
    let total: Double
    let income: Double
    let expenses: Double
    
    var body: some View {
        
        ZStack {
            Image("balance-background")
                .resizable()
                .clipped()
                .cornerRadius(12)
                        
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Total Balance")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                    }
                    
                    Text("$\(total, specifier: "%.2f")")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
                Spacer()
                
                HStack(spacing: 50) {
                    VStack (alignment: .leading){
                        HStack {
                            Image(systemName: "arrow.down")
                                .foregroundColor(.white)
                                .padding(.all, 5)
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.15))
                                        .frame(width: 30, height: 30)
                                )
                            
                            Text("Income")
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        Text("$\(income, specifier: "%.2f")")
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack (alignment: .trailing) {
                        HStack {
                            Image(systemName: "arrow.down")
                                .rotationEffect(.degrees(180))
                                .foregroundColor(.white)
                                .padding(.all, 5)
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.15))
                                        .frame(width: 30, height: 30)
                                )
                            
                            Text("Expenses")
                                .foregroundColor(.white.opacity(0.8))
                        }
                        Text("$\(expenses, specifier: "%.2f")")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                .padding()
            }
        }
        .frame(height: 200)
        .padding()
    }
}

#Preview("Positive Balance") {
    BalanceCardView(
        total: 5000,
        income: 8000,
        expenses: 3000
    )
}

#Preview("Zero Balance") {
    BalanceCardView(
        total: 0,
        income: 0,
        expenses: 0
    )
}

#Preview("Negative Balance") {
    BalanceCardView(
        total: -200,
        income: 1000,
        expenses: 1200
    )
}
