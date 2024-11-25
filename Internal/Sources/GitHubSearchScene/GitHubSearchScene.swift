//
//  GithubSerchScene.swift
//  Internal
//
//  Created by katsumi on 2024/11/24
//

import SwiftUI
import ComposableArchitecture
import Domain

public struct GitHubSearchScene: View {
    public init() {}
    
    @State private var repositories = GitHubRepository.mockData
    @State private var searchText = ""
    
    private var filteredRepositories: [GitHubRepository] {
        if searchText.isEmpty {
            return repositories
        } else {
            return repositories.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    public var body: some View {
        NavigationView {
            List(filteredRepositories, id: \.id) { repo in
                VStack(alignment: .leading) {
                    Text(repo.name)
                        .font(.headline)
                    Text(repo.description ?? "No description")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Stars: \(repo.stargazersCount)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("GitHub")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search repositories"
            )
        }
    }
}

#Preview {
    GitHubSearchScene()
}
