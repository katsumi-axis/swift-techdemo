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
    public init(store: StoreOf<GitHubSearchReducer>) {
        self.store = store
    }
    let store: StoreOf<GitHubSearchReducer>

    public var body: some View {
        NavigationView {
            List(store.repositories, id: \.id) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.bio ?? "No bio")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Followers: \(user.followers)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("GitHub")
            .searchable(
                text: Binding(
                    get: { store.query },
                    set: { newValue in
                        
                    }
                ),
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search repositories"
            )
        }
    }
}

#Preview {
    GitHubSearchScene(store: .init(initialState: GitHubSearchReducer.State(), reducer: { GitHubSearchReducer() })) 
}
