//
//  GithubRepositoryProtocol.swift
//  TrendyRepos
//
//  Created by adamwienconek on 11/03/2025.
//

import Foundation

public protocol GithubRepositoryProtocol: Identifiable, Hashable, Sendable {
    var name: String { get }
    var owner: (any RepositoryOwnerProtocol)? { get }
    var ownerName: String { get }
    var description: String { get }
    var path: String { get }
    var stars: Int { get }
    var forks: Int { get }
    var repositoryURL: URL { get }
}

public extension GithubRepositoryProtocol {
    var repositoryURL: URL {
        var comp = URLComponents(string: "https://github.com")!
        comp.path = path
        
        return comp.url!
    }
}

public extension GithubRepositoryProtocol where Self: Identifiable {
    var id: String { path }
}
