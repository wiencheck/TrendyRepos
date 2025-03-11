//
//  TrendingRepositoriesView.swift
//  SplunkTest
//
//  Created by Adaś on 11/03/2025.
//

import SwiftUI
import SplunkTestGithubService

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

#Preview {
    TrendingRepositoriesView(
        viewModel: TrendingRepositoriesViewModel.preview
    )
}
