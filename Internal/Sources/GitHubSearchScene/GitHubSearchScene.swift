//
//  GithubSerchScene.swift
//  Internal
//
//  Created by katsumi on 2024/11/24
//

import ComposableArchitecture
import Domain
import SwiftUI

public struct GitHubSearchScene: View {
    public init(store: StoreOf<GitHubSearchReducer>) {
        self.store = store
    }
    let store: StoreOf<GitHubSearchReducer>

    public var body: some View {
        NavigationView {
            List(store.repositories, id: \.id) { repo in
                VStack(alignment: .leading) {
                    Text(repo.name)
                        .font(.headline)
                    Text(repo.url)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(String(repo.stargazers_count))
                        .font(.subheadline)
                }
            }
            .navigationTitle("GitHub")
            .searchable(
                text: Binding(
                    get: { store.query },
                    set: { store.send(.queryChanged($0)) }
                ),
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search repositories"
            )
            .onSubmit(of: .search) {
                store.send(.search)
            }
        }
    }
}

#Preview {
    GitHubSearchScene(
        store: .init(
            initialState: GitHubSearchReducer.State(),
            reducer: { GitHubSearchReducer() }))
}
