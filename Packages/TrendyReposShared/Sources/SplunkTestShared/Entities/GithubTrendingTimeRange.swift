//
//  GithubTimeRange.swift
//  TrendyReposGithubService
//
//  Created by adamwienconek on 11/03/2025.
//

import Foundation

public enum GithubTrendingTimeRange: Int, Hashable, Identifiable, CaseIterable {
    
    case today, thisWeek, thisMonth
    
    public var id: Int { rawValue }
    
    public var localizedTitle: String {
        switch self {
        case .today:
            "Today"
        case .thisWeek:
            "This week"
        case .thisMonth:
            "This month"
        }
    }
    
    public var queryParameter: String {
        switch self {
        case .today:
            "daily"
        case .thisWeek:
            "weekly"
        case .thisMonth:
            "monthly"
        }
    }
    
}
