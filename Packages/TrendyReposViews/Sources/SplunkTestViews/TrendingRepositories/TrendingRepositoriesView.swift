//
//  TrendingRepositoriesView.swift
//  TrendyRepos
//
//  Created by adamwienconek on 11/03/2025.
//

import SwiftUI
import TrendyReposShared

public struct TrendingRepositoriesView<ViewModel>: View where ViewModel: TrendingRepositoriesViewModelProtocol & ObservableObject {
    
    @AppStorage("daterange")
    private var dateRange: GithubTrendingTimeRange = .today
    
    @StateObject
    private var viewModel: ViewModel
    public init(
        viewModel: ViewModel
    ) {
        self._viewModel = StateObject(
            wrappedValue: viewModel
        )
    }
    
    public var body: some View {
        List(viewModel.repositories, id: \.path) { repository in
            NavigationLink(value: repository.path) {
                RepositoryCellView(repository: repository)
            }
        }
        .disabled(viewModel.isLoading)
        .navigationTitle(
            "Trending \(dateRange.localizedTitle)".capitalized
        )
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
                Menu {
                    Section("Date range:") {
                        Picker(
                            selection: $dateRange,
                            label: Text(dateRange.localizedTitle)
                                .foregroundStyle(.secondary)
                        ) {
                            ForEach(GithubTrendingTimeRange.allCases) { range in
                                Text(range.localizedTitle)
                                    .tag(range)
                            }
                        }
                        .pickerStyle(.inline)
                    }
                    
                    Section {
                        Button {
                            NotificationCenter.default.post(
                                name: .presentSettings,
                                object: nil
                            )
                        } label: {
                            Label("Open Settings", systemImage: "gear")
                        }

                    }
                } label: {
                    Label("", systemImage: "ellipsis.circle")
                }
            }
        }
    }
}

final class TrendingRepositoriesViewModel_Preview: TrendingRepositoriesViewModelProtocol, ObservableObject {
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

#Preview {
    NavigationStack {
        TrendingRepositoriesView(
            viewModel: TrendingRepositoriesViewModel_Preview()
        )
    }
}
