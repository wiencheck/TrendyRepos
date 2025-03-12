//
//  TrendingRepositories+ViewModel.swift
//  SplunkTest
//
//  Created by Adaś on 11/03/2025.
//

import Observation
import SplunkTestGithubService
import SplunkTestShared
import SplunkTestViews

@Observable
final class TrendingRepositoriesViewModel: TrendingRepositoriesViewModelProtocol {
    
    fileprivate(set) var repositories: [any GithubRepositoryProtocol] = []
    
    fileprivate(set) var isLoading: Bool = false
    
    private var _task: Task<Void, Never>? {
        willSet {
            _task?.cancel()
        }
    }
    
    func loadTrendingRepositories(in range: GithubTrendingTimeRange) {
        isLoading = true
        
        _task = .detached(priority: .high) { [weak self] in
            do {
                self?.repositories = try await GithubService.fetchTrendingRepositories(range: range)
            }
            catch {
                print(error)
            }
            self?.isLoading = false
        }
    }
    
}
