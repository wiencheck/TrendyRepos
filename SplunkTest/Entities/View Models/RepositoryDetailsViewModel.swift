//
//  RepositoryDetailsViewModel.swift
//  SplunkTest
//
//  Created by Adaś on 12/03/2025.
//

import Observation
import SplunkTestShared
import SplunkTestViews

@Observable
final class RepositoryDetailsViewModel: RepositoryDetailsViewModelProtocol {
    
    var repository: (any GithubRepositoryProtocol)? {
        GithubRepositoryMock(
            name: "Test",
            author: "adw",
            description: "Test repository",
            path: "/Test/adw",
            stars: 666,
            forks: 6969
        )
    }
    
    private let path: String
    init(path: String) {
        self.path = path
    }
    
    func loadRepositoryDetails() {
        
    }
    
}
