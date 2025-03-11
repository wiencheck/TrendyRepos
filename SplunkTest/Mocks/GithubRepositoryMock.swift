//
//  GithubRepositoryMock.swift
//  SplunkTest
//
//  Created by Adaś on 11/03/2025.
//

import Foundation
import SplunkTestShared

struct GithubRepositoryMock: GithubRepositoryProtocol {
    var name: String
    var author: String
    var description: String
    var path: String
    var stars: Int
    var forks: Int
}
