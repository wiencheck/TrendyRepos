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
    public var name: String// This will be assigned manually when parsing from HTML
    public var description: String
    public var stars: Int
    public var forks: Int
    public var repositoryURL: URL
    
    private var _ownerName: String = ""
    private var _owner: RepositoryOwner?
    
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
        self._ownerName = ownerName
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
    
    public var owner: (any RepositoryOwnerProtocol)? {
        _owner
    }
    
    public var ownerName: String {
        if !_ownerName.isEmpty {
            return _ownerName
        }
        return owner?.name ?? ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, forks
        case _owner = "owner"
        case stars = "stargazers_count"
        case repositoryURL = "html_url"
    }
    
}


