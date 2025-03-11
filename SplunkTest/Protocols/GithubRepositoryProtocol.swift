//
//  GithubRepositoryProtocol.swift
//  SplunkTest
//
//  Created by Adaś on 11/03/2025.
//

import Foundation
import SplunkTestGithubService

protocol GithubRepositoryProtocol: Identifiable, Hashable, Sendable {
    var name: String { get }
    var author: String { get }
    var description: String { get }
    var path: String { get }
    var stars: Int { get }
    var forks: Int { get }
    var repositoryURL: URL { get }
}

extension GithubRepositoryProtocol {
    var repositoryURL: URL {
        var comp = URLComponents(string: "https://github.com")!
        comp.path = path
        
        return comp.url!
    }
}

extension GithubRepositoryProtocol where Self: Identifiable {
    var id: String { path }
}

extension GithubRepository: GithubRepositoryProtocol {}
