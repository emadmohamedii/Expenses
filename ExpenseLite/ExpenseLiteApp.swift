//
//  ExpenseLiteApp.swift
//  ExpenseLite
//
//  Created by Emad Habib on 06/08/2025.
//

import SwiftUI

@main
struct ExpenseLiteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
