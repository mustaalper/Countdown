//
//  CountdownApp.swift
//  Countdown
//
//  Created by MAA on 31.08.2022.
//

import SwiftUI

@main
struct CountdownApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
