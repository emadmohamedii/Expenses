//
//  AddExpenseView.swift
//  ExpenseLite
//
//  Created by Emad Habib on 07/08/2025.
//

import SwiftUI

struct AddExpenseView: View {
    @State private var showPicker = false
    @State private var showImagePicker = false
    @State private var showFilePicker = false
    @StateObject var viewModel: AddExpenseViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedCurrency: String = "USD"
    
    let currencies = ["USD", "EUR", "EGP", "GBP", "SAR"]
    let categories = ["Groceries", "Entertainment", "Gas", "Shopping", "News Paper", "Transport", "Rent"]
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    categoryMenu
                    AmountInputView(amount: $viewModel.amount, selectedCurrency: $selectedCurrency)
                    datePickerButton
                    receiptButton
                    CategoriesGridView(selectedCategory: $viewModel.category)
                    Spacer(minLength: 100)
                }
                .padding(.horizontal)
                .padding(.top)
            }
                        
            VStack {
                Spacer()
                
                Button(action: {
                    Task { await viewModel.saveExpense() }
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .shadow(radius: 3)
                }
                .background(Color.white.ignoresSafeArea(edges: .bottom))
            }
        }
        .alert("Saved!", isPresented: $viewModel.saveSuccess) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        }
        .alert("Error", isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { newValue in
                if !newValue {
                    viewModel.errorMessage = nil
                }
            }
        )) {
            Button("OK", role: .cancel) {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        
        if viewModel.isSaving {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            ProgressView("Saving...")
                .padding()
                .background(Color.white)
                .cornerRadius(10)
        }
    }
    
    // MARK: - Subviews for cleanliness

    private var categoryMenu: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Categories").font(.headline)
            Menu {
                ForEach(categories, id: \.self) { category in
                    Button(category) {
                        viewModel.category = category
                    }
                }
            } label: {
                HStack {
                    Text(viewModel.category).foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "chevron.down").foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
        }
    }
    
    private var datePickerButton: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Date").font(.headline)
            Button { showPicker.toggle() } label: {
                HStack {
                    Text(viewModel.date, format: .dateTime.month().day().year())
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
            .sheet(isPresented: $showPicker) {
                DatePicker("", selection: $viewModel.date, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .padding()
            }
        }
    }

    private var receiptButton: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Attach Receipt").font(.headline)

            HStack(spacing: 12) {
                Button {
                    showImagePicker.toggle()
                } label: {
                    HStack {
                        Text(viewModel.receiptImage == nil ? "Upload Image" : "Image Selected")
                        Spacer()
                        Image(systemName: "photo.on.rectangle")
                    }
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }

                Button {
                    showFilePicker.toggle()
                } label: {
                    HStack {
                        Text(viewModel.receiptFileURL == nil ? "Upload File" : viewModel.receiptFileURL?.lastPathComponent ?? "File Selected")
                        Spacer()
                        Image(systemName: "doc")
                    }
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
            }
            
            // Image preview
            if let image = viewModel.receiptImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
            }

            // File name display
            if let file = viewModel.receiptFileURL {
                Text("Selected File: \(file.lastPathComponent)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $viewModel.receiptImage)
        }
        .sheet(isPresented: $showFilePicker) {
            FilePicker(selectedFileURL: $viewModel.receiptFileURL)
        }
    }
}

#Preview {
    AddExpenseView(viewModel: AddExpenseViewModel.init(repository: MockExpenseRepository()))
}
