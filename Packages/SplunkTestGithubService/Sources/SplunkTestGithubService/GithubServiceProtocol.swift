//
//  GithubServiceProtocol.swift
//  SplunkTestGithubService
//
//  Created by Adaś on 11/03/2025.
//

protocol GithubServiceProtocol {
    
    static func fetchTrendingRepositories() async throws -> [GithubRepository]
    
}
