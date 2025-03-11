//
//  TrendingRepositories+ViewModel.swift
//  SplunkTest
//
//  Created by Adaś on 11/03/2025.
//

import Observation
import SplunkTestGithubService

@Observable
final class TrendingRepositoriesViewModel: TrendingRepositoriesViewModelProtocol {
    
    fileprivate(set) var repositories: [any GithubRepositoryProtocol] = []
    
    fileprivate(set) var isLoading: Bool = false
    
    private var _task: Task<Void, Never>? {
        willSet {
            _task?.cancel()
        }
    }
    
    func loadTrendingRepositories() {
        isLoading = true
        
        _task = .detached(priority: .high) { [weak self] in
            do {
                self?.repositories = try await GithubService.fetchTrendingRepositories(range: .today)
            }
            catch {
                print(error)
            }
        }
    }
    
}

extension TrendingRepositoriesViewModel {
    
    static var preview: TrendingRepositoriesViewModel {
        let viewModel = TrendingRepositoriesViewModel()
        viewModel.repositories = [
            GithubRepositoryMock(
                name: "Test",
                author: "adw",
                description: "Test repository",
                path: "/Test/adw",
                stars: 666,
                forks: 6969
            )
        ]
        // viewModel.isLoading = true
        
        return viewModel
    }
    
}
