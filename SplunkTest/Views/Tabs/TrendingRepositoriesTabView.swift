//
//  TrendingRepositoriesTabView.swift
//  SplunkTest
//
//  Created by Adaś on 12/03/2025.
//

import SwiftUI
import SplunkTestShared
import SplunkTestViews

struct TrendingRepositoriesTabView: View {
    
    @State
    private var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            TrendingRepositoriesView(
                viewModel: TrendingRepositoriesViewModel()
            )
            .navigationDestination(
                for: String.self,
                destination: { path in
                    RepositoryDetailsView(
                        viewModel: RepositoryDetailsViewModel(path: path)
                    )
                }
            )
        }
    }
}

#Preview {
    TrendingRepositoriesTabView()
}
