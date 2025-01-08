//
//  offlineFileAppApp.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 08/01/25.
//

import SwiftUI

@main
struct offlineFileAppApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
