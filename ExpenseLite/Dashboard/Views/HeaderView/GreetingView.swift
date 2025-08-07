//
//  GreetingView.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import SwiftUI

struct GreetingView: View {
    @Binding var selectedFilter: ExpenseFilter
    
    var body: some View {
        // Greeting
        HStack {
            Image(systemName: "person.fill")
                .padding()
                .background(
                    RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                        .fill(Color.gray)
                )
            VStack(alignment: .leading) {
                Text("Good Morning")
                    .font(.caption)
                    .foregroundColor(.white)
                Text("Shihab Rahman")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
            }
            Spacer()
            
            DateRangePickerView(selectedFilter: $selectedFilter)
        }
        .padding(.horizontal)
        .padding(.top, 16)
    }
}

#Preview {
    GreetingView(selectedFilter: .constant(.thisMonth))
}
