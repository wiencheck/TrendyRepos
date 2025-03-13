//
//  TrendingRepositoriesView.swift
//  SplunkTest
//
//  Created by Adaś on 11/03/2025.
//

import SwiftUI
import SplunkTestShared

public struct TrendingRepositoriesView: View {
    
    @State
    private var dateRange: GithubTrendingTimeRange = .today
    
    let viewModel: any TrendingRepositoriesViewModelProtocol
    public init(
        viewModel: any TrendingRepositoriesViewModelProtocol
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        List(viewModel.repositories, id: \.id) { repository in
            NavigationLink(value: repository.path) {
                RepositoryCellView(repository: repository)
            }
        }
        .disabled(viewModel.isLoading)
        .navigationTitle("Trending")
        .overlay {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(
                        CircularProgressViewStyle()
                    )
            }
        }
        .onChange(of: dateRange, initial: true) { oldValue, newValue in
            if viewModel.repositories.isEmpty || newValue != oldValue {
                viewModel.loadTrendingRepositories(in: newValue)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Picker(
                    selection: $dateRange,
                    label: Text("Sorting options")
                ) {
                    ForEach(GithubTrendingTimeRange.allCases) { range in
                        Text(range.localizedTitle)
                            .tag(range)
                    }
                }
                .pickerStyle(.menu)
            }
        }
    }
}

struct TrendingRepositoriesViewModel_Preview: TrendingRepositoriesViewModelProtocol {
    var repositories: [any GithubRepositoryProtocol] {
        [
            GithubRepositoryMock(
                name: "Test",
                ownerName: "adw",
                description: "Test repository",
                path: "/Test/adw",
                stars: 666,
                forks: 6969
            )
        ]
    }
    
    var isLoading: Bool { false }
    
    func loadTrendingRepositories(in range: GithubTrendingTimeRange) {
        
    }
    
    
}

//#Preview {
//    NavigationStack {
//        TrendingRepositoriesView(
//            viewModel: TrendingRepositoriesViewModel_Preview()
//        )
//    }
//}
