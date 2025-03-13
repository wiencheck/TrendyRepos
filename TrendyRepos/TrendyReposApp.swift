//
//  TrendyReposApp.swift
//  TrendyRepos
//
//  Created by Adaś on 11/03/2025.
//

import SwiftUI
import TrendyReposViews

@main
struct TrendyReposApp: App {
    
    @State
    private var path: String?
    
    @State
    private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    
    @AppStorage("forcedarkmode")
    private var forceDarkMode: Bool = false
    
    @State
    private var presentSettings: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView(columnVisibility: $columnVisibility) {
                TrendingRepositoriesView(
                    viewModel: TrendingRepositoriesViewModel()
                )
                .navigationDestination(for: String.self) { path in
                    RepositoryDetailsView(
                        viewModel: RepositoryDetailsViewModel(path: path)
                    )
                    .id(path)
                }
            } detail: {
                ContentUnavailableView(
                    "Welcome to TrendyRepos",
                    systemImage: "chart.line.uptrend.xyaxis",
                    description: Text("Select a repository to view its details")
                )
            }
            .navigationSplitViewStyle(.balanced)
            .preferredColorScheme(
                forceDarkMode ? .dark : nil
            )
            .sheet(isPresented: $presentSettings) {
                presentSettings = false
            } content: {
                NavigationStack {
                    SettingsView()
                }
            }
            .onReceive(
                NotificationCenter.default.publisher(for: .presentSettings)) { _ in
                    presentSettings = true
                }
        }
    }
}
