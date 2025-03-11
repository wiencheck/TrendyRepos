//
//  TrendingRepositoriesView.swift
//  SplunkTest
//
//  Created by Adaś on 11/03/2025.
//

import SwiftUI
import SplunkTestShared

public struct TrendingRepositoriesView: View {
    
    let viewModel: any TrendingRepositoriesViewModelProtocol
    public init(
        viewModel: any TrendingRepositoriesViewModelProtocol
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(
                    CircularProgressViewStyle()
                )
        }
        else {
            Text(viewModel.repositories[0].name)
        }
    }
}

struct TrendingRepositoriesViewModel_Preview: TrendingRepositoriesViewModelProtocol {
    var repositories: [any GithubRepositoryProtocol] {
        [
            GithubRepositoryMock(
                name: "Test",
                author: "adw",
                description: "Test repository",
                path: "/Test/adw",
                stars: 666,
                forks: 6969
            )
        ]
    }
    
    var isLoading: Bool { false }
    
    func loadTrendingRepositories() {}
    
    
}

#Preview {
    TrendingRepositoriesView(
        viewModel: TrendingRepositoriesViewModel_Preview()
    )
}
