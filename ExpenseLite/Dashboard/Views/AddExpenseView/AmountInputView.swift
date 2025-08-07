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
        let filtered = newValue.filter { "0123456789.".contains($0) }
        let components = filtered.split(separator: ".")
        if components.count > 2 {
            amount = String(components[0]) + "." + String(components[1])
        } else {
            amount = String(filtered.prefix(7))
        }
    }
}

#Preview {
    AmountInputView(
        amount: .constant("1"),
        selectedCurrency: .constant("1")
    )
}
