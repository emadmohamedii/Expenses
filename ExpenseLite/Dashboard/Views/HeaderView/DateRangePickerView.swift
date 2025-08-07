//
//  DateRangePickerView.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import SwiftUI

struct DateRangePickerView: View {
    @Binding var selectedFilter: ExpenseFilter
    
    var body: some View {
        Menu {
            ForEach(ExpenseFilter.allCases, id: \.self) { filter in
                Button(action: {
                    selectedFilter = filter
                }) {
                    Text(filter.title)
                }
            }
        } label: {
            HStack(spacing: 4) {
                Text(selectedFilter.title)
                    .foregroundColor(.black)
                Image(systemName: "chevron.down")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.white)
            .cornerRadius(12)
        }
    }
}

#Preview {
    DateRangePickerView(selectedFilter: .constant(.thisMonth))
}
