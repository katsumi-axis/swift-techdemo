//
//  GithubSerchScene.swift
//  Internal
//
//  Created by katsumi on 2024/11/24
//

import SwiftUI

public struct GitHubSearchScene: View {
    public init() {}
    @State private var repositories = [
        "SwiftUI-App",
        "iOS-Learning",
        "Swift-Examples"
    ]
    
    public var body: some View {
        NavigationView {
            List(repositories, id: \.self) { repo in
                VStack(alignment: .leading) {
                    Text(repo)
                        .font(.headline)
                    Text("Last updated: 2024/11/23")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("GitHub")
        }
    }
}
