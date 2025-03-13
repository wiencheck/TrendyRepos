//
//  TrendingRepositoriesViewModelProtocol.swift
//  TrendyRepos
//
//  Created by adamwienconek on 11/03/2025.
//

import TrendyReposShared

public protocol TrendingRepositoriesViewModelProtocol {
    var repositories: [any GithubRepositoryProtocol] { get }
    var isLoading: Bool { get }
    
    func loadTrendingRepositories(in range: GithubTrendingTimeRange)
}
