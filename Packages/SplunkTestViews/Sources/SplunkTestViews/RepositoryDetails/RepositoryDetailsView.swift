//
//  RepositoryDetailsView.swift
//  SplunkTestViews
//
//  Created by Adaś on 12/03/2025.
//

import SwiftUI
import SplunkTestShared

public protocol RepositoryDetailsViewModelProtocol {
    
    var repository: (any GithubRepositoryProtocol)? { get }
    var isLoading: Bool { get }
    var error: (any Error)? { get }
    
    func loadRepositoryDetails()
    
}

final class RepositoryDetailsViewModel_Preview: RepositoryDetailsViewModelProtocol {
    
    var repository: (any GithubRepositoryProtocol)? {
        GithubRepositoryMock(
            name: "Test",
            ownerName: "adw",
            description: "Test repository",
            path: "/Test/adw",
            stars: 666,
            forks: 6969
        )
    }
    
    var isLoading: Bool { false }
    
    var error: (any Error)? { nil }
    
    func loadRepositoryDetails() {}
    
}

public struct RepositoryDetailsView: View {
    
    @State
    private var opacity: [Double] = [1,1,1]
    
    private let viewModel: any RepositoryDetailsViewModelProtocol
    public init(
        viewModel: any RepositoryDetailsViewModelProtocol
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView {
            if let repository = viewModel.repository {
                Spacer(minLength: 12)
                
                GroupBox {
                    HStack {
                        if let avatarURL = repository.owner?.avatarURL {
                            AsyncImage(url: avatarURL) { result in
                                result.image?
                                    .resizable()
                                    .scaledToFill()
                            }
                            .frame(width: 64, height: 64)
                            .clipShape(
                                Circle()
                            )
                            
                            Spacer()
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Owner")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                            Text(repository.ownerName)
                                .font(.headline)
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    }
                }
                
                GroupBox {
                    VStack(alignment: .leading) {
                        Text("About")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        Text(repository.description)
                            .font(.headline)
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                }
                
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(),
                        count: 2
                    ),
                    content: {
                        withAnimation(.easeInOut.delay(2)) {
                            GroupBox {
                                VStack(alignment: .leading) {
                                    Text("Stars")
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                    
                                    HStack(spacing: 4) {
                                        Image(systemName: "star")
                                        
                                        Text("\(repository.stars)")
                                    }
                                    .font(.subheadline)
                                }
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )
                            }
                            .opacity(opacity[1])
                        }
                        withAnimation(.easeInOut.delay(3)) {
                            GroupBox {
                                VStack(alignment: .leading) {
                                    Text("Forks")
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                    HStack(spacing: 4) {
                                        Image(systemName: "tuningfork")
                                        
                                        Text("\(repository.forks)")
                                    }
                                    .font(.subheadline)
                                }
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )
                            }
                            .opacity(opacity[2])
                        }
                    }
                )
                
                Spacer(minLength: 40)
                
                Link(
                    "Open in Safari",
                    destination: repository.repositoryURL
                )
            }
            else {
                
            }
        }
        .padding(.horizontal)
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .refreshable {
            viewModel.loadRepositoryDetails()
        }
        .navigationTitle(viewModel.repository?.name ?? "Repository")
        .onAppear {
            viewModel.loadRepositoryDetails()
        }
    }
    
    private var groupDetails: [GroupBoxDetails] {
        [
            // Stars
            
            // Forks
            

        ]
    }
    
}

private extension RepositoryDetailsView {
    
    struct GroupBoxDetails {
        var title: String
        var text: String
        var icon: String
    }
    
}

#Preview {
    NavigationStack {
        RepositoryDetailsView(
            viewModel: RepositoryDetailsViewModel_Preview()
        )
    }
}
