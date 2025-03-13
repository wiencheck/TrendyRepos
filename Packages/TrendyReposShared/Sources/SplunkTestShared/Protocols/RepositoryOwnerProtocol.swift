//
//  RepositoryOwner.swift
//  TrendyReposShared
//
//  Created by adamwienconek on 12/03/2025.
//

import Foundation

public protocol RepositoryOwnerProtocol: Sendable, Identifiable, Decodable, Hashable {
    
    var id: Int { get }
    var name: String { get }
    var avatarURL: URL? { get }
    
}
