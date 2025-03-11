//
//  GithubTimeRange.swift
//  SplunkTestGithubService
//
//  Created by adamwienconek on 11/03/2025.
//

public enum GithubTrendingTimeRange {
    
    case today, thisWeek, thisMonth
    
    var parameter: String {
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
