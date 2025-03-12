//
//  SplunkTestApp.swift
//  SplunkTest
//
//  Created by Adaś on 11/03/2025.
//

import SwiftUI

@main
struct SplunkTestApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                TrendingRepositoriesTabView()
                    .tabItem {
                        Label("Trending", systemImage: "chart.line.uptrend.xyaxis")
                    }
                
                SettingsTabView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}
