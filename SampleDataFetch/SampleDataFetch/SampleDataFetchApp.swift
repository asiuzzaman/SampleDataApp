//
//  SampleDataFetchApp.swift
//  SampleDataFetch
//
//  Created by Md. Asiuzzaman on 20/3/25.
//

import SwiftUI

@main
struct SampleDataFetchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
