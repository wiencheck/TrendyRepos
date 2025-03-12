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
    
    func loadRepositoryDetails()
    
}

final class RepositoryDetailsViewModel_Preview: RepositoryDetailsViewModelProtocol {
    
    var repository: (any GithubRepositoryProtocol)? {
        GithubRepositoryMock(
            name: "Test",
            author: "adw",
            description: "Test repository",
            path: "/Test/adw",
            stars: 666,
            forks: 6969
        )
    }
    
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
                    VStack(alignment: .leading) {
                        Text(repository.name)
                    }
                } label: {
                    Label(repository.author, image: "")
                }

                
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(),
                        count: 2
                    ),
                    content: {
                        withAnimation(.easeInOut.delay(1)) {
                            GroupBox {
                                Text(repository.description)
                            } label: {
                                Label("Description", image: "")
                            }
                            .opacity(opacity[0])
                        }
                        withAnimation(.easeInOut.delay(2)) {
                            GroupBox {
                                Text("\(repository.stars)")
                            } label: {
                                Label("Stars", image: "")
                            }
                            .opacity(opacity[1])
                        }
                        withAnimation(.easeInOut.delay(3)) {
                            GroupBox {
                                Text("\(repository.forks)")
                            } label: {
                                Label("Forks", image: "")
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
        .navigationTitle("Repo details")
    }
    
//    private var cellDetails: [CellDetails] {
//        [
//            // Stars
//            
//            // Forks
//            
//
//        ]
//    }
    
}

private extension RepositoryDetailsView {
    
    struct CellDetails {
        var title: String
        var text: String
        var icon: String
    }
    
}

#Preview {
    RepositoryDetailsView(
        viewModel: RepositoryDetailsViewModel_Preview()
    )
}
