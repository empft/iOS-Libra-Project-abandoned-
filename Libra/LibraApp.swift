//
//  LibraApp.swift
//  Libra
//
//  Created by Big Sur on 28/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import SwiftUI

@main
struct LibraApp: App {
    let coreData = EnderStorage.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreData.container.viewContext)
        }
    }
}
