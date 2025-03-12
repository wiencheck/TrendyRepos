//
//  GithubRepositoryMock.swift
//  SplunkTest
//
//  Created by Adaś on 11/03/2025.
//

import Foundation
import SplunkTestShared

public struct GithubRepositoryMock: GithubRepositoryProtocol {
    public var name: String
    public var ownerName: String
    public var description: String
    public var path: String
    public var stars: Int
    public var forks: Int
    
    public init(
        name: String,
        ownerName: String,
        description: String,
        path: String,
        stars: Int,
        forks: Int
    ) {
        self.name = name
        self.ownerName = ownerName
        self.description = description
        self.path = path
        self.stars = stars
        self.forks = forks
    }
    
}
