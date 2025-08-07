//
//  AmountInputView.swift
//  ExpenseLite
//
//  Created by Emad Habib on 08/08/2025.
//

import SwiftUI

struct AmountInputView: View {
    @Binding var amount: String
    @Binding var selectedCurrency: String

    let currencies: [(code: String, symbol: String)] = [
        ("USD", "$"),
        ("EUR", "€"),
        ("EGP", "E£"),
        ("GBP", "£"),
        ("SAR", "﷼"),
        ("JPY", "¥"),
        ("INR", "₹")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Amount")
                .font(.headline)

            HStack(spacing: 0) {
                // Display selected currency symbol
                Text(currencySymbol(for: selectedCurrency))
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)

                // Input field for amount
                TextField("0.00", text: $amount)
                    .keyboardType(.decimalPad)
                    .onChange(of: amount) { newValue in
                        filterAmountInput(newValue)
                    }
                    .padding(15)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)

                // Dropdown menu for currency selection
                Menu {
                    ForEach(currencies, id: \.code) { currency in
                        Button(action: {
                            selectedCurrency = currency.code
                        }) {
                            Text("\(currency.code) \(currency.symbol)")
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedCurrency)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 12)
                }
            }
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .padding(.top, 8)
    }

    // Helper to get currency symbol
    private func currencySymbol(for code: String) -> String {
        currencies.first(where: { $0.code == code })?.symbol ?? "$"
    }

    // Filter logic: only allow valid numeric input up to 7 characters
    private func filterAmountInput(_ newValue: String) {
        // Remove invalid characters (allow only digits and one dot)
        var filtered = newValue.filter { "0123456789.".contains($0) }
        
        // Ensure only one decimal point is present
        let dotCount = filtered.filter { $0 == "." }.count
        if dotCount > 1 {
            // Keep only the first dot
            if let firstDotIndex = filtered.firstIndex(of: ".") {
                filtered = filtered.prefix(through: firstDotIndex) + filtered.dropFirst(firstDotIndex.utf16Offset(in: filtered)).replacingOccurrences(of: ".", with: "")
            }
        }

        // Limit to two decimal places
        if let dotIndex = filtered.firstIndex(of: ".") {
            let whole = filtered[..<dotIndex]
            let fractional = filtered[filtered.index(after: dotIndex)...].prefix(2)
            filtered = whole + "." + fractional
        }

        // Limit total length to 9 characters (e.g., "999999.99")
        amount = String(filtered.prefix(9))
    }
    
}

#Preview {
    AmountInputView(
        amount: .constant("1"),
        selectedCurrency: .constant("1")
    )
}
