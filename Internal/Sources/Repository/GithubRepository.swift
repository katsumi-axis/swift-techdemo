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
  
    public func searchRepositories(query: String) async throws -> [GitHubRepo] {
        
        if (query == ""){
            return []
        }
        
        let url = URL(string: "https://api.github.com/search/repositories?q=\(query)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(GitHubSearchResponse.self, from: data)
        return response.items
    }
}

struct GitHubSearchResponse: Decodable {
    let items: [GitHubRepo]
}

protocol GitHubRepositoryProtocol {
    func searchRepositories(query: String) async throws -> [GitHubRepo]
}
