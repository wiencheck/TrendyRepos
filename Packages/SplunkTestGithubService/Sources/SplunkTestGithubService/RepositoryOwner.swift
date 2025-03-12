//
//  RepositoryOwner.swift
//  SplunkTestGithubService
//
//  Created by Adaś on 12/03/2025.
//

import Foundation

public struct RepositoryOwner: Sendable, Identifiable, Decodable, Hashable {
    
    public let id: Int
    public let name: String
    public let avatarURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case avatarURL = "avatar_url"
    }
    
}
