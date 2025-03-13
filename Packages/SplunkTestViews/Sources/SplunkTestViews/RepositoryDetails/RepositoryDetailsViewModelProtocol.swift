//
//  RepositoryDetailsViewModelProtocol.swift
//  SplunkTestViews
//
//  Created by Adam Wienconek on 13/03/2025.
//

import SplunkTestShared

public protocol RepositoryDetailsViewModelProtocol {
    
    var repository: (any GithubRepositoryProtocol)? { get }
    var isLoading: Bool { get }
    var error: (any Error)? { get }
    
    func loadRepositoryDetails()
    
}
