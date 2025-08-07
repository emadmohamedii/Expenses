# 📱 ExpenseLite – iOS Expense Tracker

ExpenseLite is a lightweight SwiftUI-based expense tracker app built for iOS. It allows users to add, view, and manage expenses with support for receipt uploads, currency conversion, offline storage, and pagination.

---

## 🧱 Architecture

The project follows **MVVM** (Model-View-ViewModel) combined with **Combine** for reactive state management.

### Structure:
- **Model**: `Expense`, `ExpenseFilter`, etc.
- **ViewModel**: `AddExpenseViewModel`, `DashboardViewModel`
- **View**: SwiftUI views composed of reusable subviews
- **Repository**: `ExpenseRepository` abstracts both local and remote data sources
- **Data Layer**:
  - CoreData for local persistence
  - CurrencyService (mocked or real) for API calls

---

## 🌐 API Integration

Currency conversion is handled via a `CurrencyService` conforming to a protocol `CurrencyServiceProtocol`.

```swift
func convert(amount: Double, from: String, to: String) async throws -> Double
```

A mock or real implementation can be swapped depending on the use case (e.g., unit testing vs live use).

---

## 🔃 Pagination Strategy

- Implemented **locally** in `DashboardViewModel` using CoreData paging.
- Load 5 items per page with `loadMore()` triggered by scroll detection.
- Can be extended to API pagination by altering `ExpenseRepository`.

---

## 🖼️ Screenshots

| Dashboard | Add Expense | Receipt Upload |
|----------|-------------|----------------|
| ![App](screenshots/https://ibb.co/hRB8Q5G8) |
 ![App](screenshots/https://ibb.co/N2mjcZ5m) 
| ![App](screenshots/https://ibb.co/WvQv6BKF)
| ![App](screenshots/https://ibb.co/8ggwVQ2k)
| ![App](screenshots/https://ibb.co/p6CJmTbH)
| ![App](screenshots/https://ibb.co/gLtBdf1H)
| ![App](screenshots/https://ibb.co/kg2SP7YK)

---

## 🚧 Known Limitations / Assumptions

- Currency conversion uses a static multiplier in mock mode (`amount * 1.1`)
- No authentication or user profiles
- Receipts are image-only (file support optional)
- UI is optimized for iPhone; iPad support not tested

---

## 🛠️ How to Build and Run

1. Open `ExpenseLite.xcodeproj` in Xcode (iOS 16+ required)
2. Run on a simulator or device
3. Dependencies:
   - SwiftUI
   - Combine
   - CoreData (native)
4. No external libraries required (100% native)

---

## 🔚 Unimplemented / Future Improvements

- Add expense editing and deletion
- Multi-currency support and user preference saving
- Graph-based analytics
- iCloud Sync
- Secure storage with biometrics
- iPad support and dynamic type accessibility

---

## 📁 Project Structure

```
ExpenseLite/
│
├── Models/
├── ViewModels/
├── Views/
├── Repository/
├── CoreData/
├── Services/
├── Resources/
└── Tests/
```

---

## 🧪 Testing

Tests implemented using `XCTest` for:

- Amount validation
- Currency conversion logic
- Repository behavior

> Run tests via `⌘ + U` or Product > Test in Xcode

---
