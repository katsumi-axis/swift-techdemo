//
//  GithubRepository.swift
//  Internal
//
//  Created by katsumi on 2024/11/24.
//

import Foundation
import Domain
import Combine

public struct GitHubRepository: GitHubRepositoryProtocol {
    public init() {}
  
    public func searchRepositories(query: String) async throws -> [GithubUser] {
        let url = URL(string: "https://api.github.com/user/\(query)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let repositories = try JSONDecoder().decode([GithubUser].self, from: data)
        return repositories
    }
}


protocol GitHubRepositoryProtocol {
    func searchRepositories(query: String) async throws -> [GithubUser]
}
