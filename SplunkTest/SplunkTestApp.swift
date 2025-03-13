//
//  SplunkTestApp.swift
//  SplunkTest
//
//  Created by Adaś on 11/03/2025.
//

import SwiftUI
import SplunkTestViews

@main
struct SplunkTestApp: App {
    
    @State
    private var path: String?
    
    @State
    private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    
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
        }
    }
}
