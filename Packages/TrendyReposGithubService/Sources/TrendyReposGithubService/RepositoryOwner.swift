//
//  RepositoryOwner.swift
//  TrendyReposGithubService
//
//  Created by adamwienconek on 12/03/2025.
//

import Foundation
import TrendyReposShared

public struct RepositoryOwner: RepositoryOwnerProtocol {
    
    public let id: Int
    public let name: String
    public let avatarURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case avatarURL = "avatar_url"
    }
    
}
