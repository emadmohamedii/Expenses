//
//  ContentView.swift
//  ExpenseLite
//
//  Created by Emad Habib on 06/08/2025.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        MainTabBarView()
    }
}

#Preview {
    ContentView()
}

struct MainTabBarView: View {
    @State private var selectedTab = 0
    @State private var showAddExpenseView = false
    @State private var refreshTrigger = UUID()

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                DashboardView(refreshTrigger: $refreshTrigger)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                
                AnalyticsView()
                    .tabItem {
                        Image(systemName: "chart.bar")
                        Text("Stats")
                    }
                    .tag(1)
                
                // Dummy hidden tab to trigger AddExpenseView
                Color.clear
                    .tabItem {
                        Text("")
                    }
                
                TransactionsView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Transactions")
                    }
                    .tag(2)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    .tag(3)
            }
            .accentColor(.blue)
            
            // Floating Add Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showAddExpenseView = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 50, height: 50)
                                .shadow(radius: 4)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom, -5)
                    .padding(.horizontal, UIScreen.main.bounds.width / 2 - 25)
                }
            }
        }
        .fullScreenCover(isPresented: $showAddExpenseView, onDismiss: {
            refreshTrigger = UUID()
        }, content: {
            AddExpenseNavigationWrapper()
        })
    }
}

struct AnalyticsView: View {
    var body: some View {
        Text("Analytics View")
            .font(.largeTitle)
    }
}

struct TransactionsView: View {
    var body: some View {
        Text("Transactions View")
            .font(.largeTitle)
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile View")
            .font(.largeTitle)
    }
}


struct AddExpenseNavigationWrapper: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: AddExpenseViewModel
    
    init() {
        let local = CoreDataDataSource()
        let currencyService = RealCurrencyService()
        let repo = ExpenseRepository(local: local, remote: currencyService)
        _viewModel = StateObject(wrappedValue: AddExpenseViewModel(repository: repo))
    }
    
    var body: some View {
        NavigationView {
            AddExpenseView(viewModel: viewModel)
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}
