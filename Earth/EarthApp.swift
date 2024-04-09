//
//  EarthApp.swift
//  Earth
//
//  Created by 이종선 on 4/9/24.
//

import SwiftUI

@main
struct EarthApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
