//
//  GithubRepository.swift
//  SplunkTestGithubService
//
//  Created by Adaś on 11/03/2025.
//

import Foundation

public struct GithubRepository: Sendable, Hashable {
    public var name: String
    public var author: String
    public var description: String
    public var path: String
    public var stars: Int
    public var forks: Int
    
    public var repositoryURL: URL {
        var comp = URLComponents(string: "https://github.com")!
        comp.path = path
        
        return comp.url!
    }
}
