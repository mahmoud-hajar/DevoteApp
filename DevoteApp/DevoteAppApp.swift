//
//  DevoteAppApp.swift
//  DevoteApp
//
//  Created by mahmoud hajar on 29/06/2021.
//

import SwiftUI

@main
struct DevoteAppApp: App {
    let persistenceController = PersistenceController.shared

    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)

        }
    }
}
