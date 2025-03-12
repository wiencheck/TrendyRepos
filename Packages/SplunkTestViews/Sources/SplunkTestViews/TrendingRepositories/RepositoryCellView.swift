//
//  RepositoryCellView.swift
//  SplunkTestViews
//
//  Created by Adaś on 12/03/2025.
//

import SwiftUI
import SplunkTestShared

public struct RepositoryCellView: View {
    
    private let repository: any GithubRepositoryProtocol
    public init(repository: any GithubRepositoryProtocol) {
        self.repository = repository
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 2) {
                Text(repository.ownerName)
                Text("/")
                Text(repository.ownerName)
                    .fontWeight(.semibold)
            }
            Text(repository.description)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
            HStack {
                HStack(spacing: 2) {
                    Image(systemName: "star")
                    Text("\(repository.stars)")
                }
                HStack(spacing: 2) {
                    Image(systemName: "tuningfork")
                    Text("\(repository.forks)")
                }
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .leading
            )
        .padding(2)
    }
}

#Preview(
    traits: .fixedLayout(
        width: 320,
        height: 88
    )
) {
    RepositoryCellView(
        repository: GithubRepositoryMock(
            name: "Test",
            ownerName: "adw",
            description: "Test repository",
            path: "/Test/adw",
            stars: 666,
            forks: 6969
        )
    )
}
