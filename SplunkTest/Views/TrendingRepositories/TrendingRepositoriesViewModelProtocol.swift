//
//  TrendingRepositoriesViewModelProtocol.swift
//  SplunkTest
//
//  Created by Adaś on 11/03/2025.
//

import SplunkTestShared

public protocol TrendingRepositoriesViewModelProtocol {
    var repositories: [any GithubRepositoryProtocol] { get }
    var isLoading: Bool { get }
    
    func loadTrendingRepositories()
}
