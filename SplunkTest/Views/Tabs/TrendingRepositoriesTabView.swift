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
    
    @State
    var p: String?
    
    var body: some View {
//        NavigationSplitView {
//            TrendingRepositoriesView(
//                viewModel: TrendingRepositoriesViewModel(),
//                path: $p
//            )
//        } detail: {
//            if let p {
//                RepositoryDetailsView(
//                    viewModel: RepositoryDetailsViewModel(path: path)
//                )
//            }
//        }

        NavigationStack(path: $path) {
            TrendingRepositoriesView(
                viewModel: TrendingRepositoriesViewModel(),
                path: $p
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
