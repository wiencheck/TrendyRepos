//
//  GithubRepository.swift
//  SplunkTestGithubService
//
//  Created by adamwienconek on 11/03/2025.
//

import Foundation
import SplunkTestShared

public struct GithubRepository: GithubRepositoryProtocol {
    public var name: String
    public var author: String
    public var description: String
    public var path: String
    public var stars: Int
    public var forks: Int
    
    public var id: String { path }
}
