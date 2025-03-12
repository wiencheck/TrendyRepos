//
//  GithubRepository.swift
//  SplunkTestGithubService
//
//  Created by adamwienconek on 11/03/2025.
//

import Foundation
import SplunkTestShared

public struct GithubRepository: GithubRepositoryProtocol, Decodable {
    
    public var id: Int
    public var name: String
    public var owner: RepositoryOwner?
    public var ownerName: String = "" // This will be assigned manually when parsing from HTML
    public var description: String
    public var stars: Int
    public var forks: Int
    public var repositoryURL: URL
    
    /// Initializer used when parsing HTML
    init?(
        name: String,
        ownerName: String,
        description: String,
        path: String,
        stars: Int,
        forks: Int
    ) {
        self.id = path.hashValue
        self.name = name
        self.ownerName = ownerName
        self.description = description
        self.stars = stars
        self.forks = forks
        
        guard let url = URL(string: "https://www.github.com" + path) else {
            return nil
        }
        self.repositoryURL = url
    }
    
    public var path: String {
        repositoryURL.relativePath
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, forks, owner
        case stars = "stargazers_count"
        case repositoryURL = "html_url"
    }
    
}


