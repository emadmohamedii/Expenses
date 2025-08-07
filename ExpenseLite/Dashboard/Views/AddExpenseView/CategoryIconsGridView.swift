//
//  CategoryIconsGridView.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
}

struct CategoriesGridView: View {
    @Binding var selectedCategory: String
    
    let categories: [Category] = [
        Category(name: "Groceries", icon: "cart", color: .blue.opacity(0.4)),
        Category(name: "Entertainment", icon: "popcorn", color: .blue),
        Category(name: "Gas", icon: "fuelpump", color: .red.opacity(0.4)),
        Category(name: "Shopping", icon: "bag", color: .orange.opacity(0.4)),
        Category(name: "News Paper", icon: "newspaper", color: .yellow.opacity(0.4)),
        Category(name: "Transport", icon: "car", color: .purple.opacity(0.4)),
        Category(name: "Rent", icon: "house", color: .brown.opacity(0.4)),
        Category(name: "Add Category", icon: "plus", color: .blue.opacity(0.4))
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Categories")
                .font(.headline)

            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(categories) { category in
                    VStack {
                        ZStack {
                            Circle()
                                .fill(category.name == selectedCategory ? category.color : Color(.systemGray6))
                                .frame(width: 40, height: 40)
                            Image(systemName: category.icon)
                                .foregroundColor(category.name == selectedCategory ? .white : .black)
                                .font(.system(size: 18))
                        }
                        Text(category.name)
                            .font(.caption)
                            .foregroundColor(category.name == selectedCategory ? .blue : .black)
                    }
                    .onTapGesture {
                        selectedCategory = category.name
                    }
                }
            }
        }
    }
}

#Preview {
    CategoriesGridView(selectedCategory: .init(projectedValue: .constant("Entertainment")))
}
