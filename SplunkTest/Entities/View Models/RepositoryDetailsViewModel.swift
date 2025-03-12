//
//  RepositoryDetailsViewModel.swift
//  SplunkTest
//
//  Created by Adaś on 12/03/2025.
//

import Observation
import SplunkTestShared
import SplunkTestGithubService
import SplunkTestViews

@Observable
final class RepositoryDetailsViewModel: RepositoryDetailsViewModelProtocol {
    
    private(set) var repository: (any GithubRepositoryProtocol)?
    
    private(set) var error: (any Error)?
    
    private(set) var isLoading: Bool = false
    
    private let path: String
    init(path: String) {
        self.path = path
    }
    
    func loadRepositoryDetails() {
        isLoading = true
        Task(priority: .high) {
            do {
                self.repository = try await GithubService.fetchRepositoryDetails(at: path)
            }
            catch {
                self.error = error
            }
            isLoading = false
        }
    }
    
}
