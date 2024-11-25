//
//  GithubRepository.swift
//  Internal
//
//  Created by katsumi on 2024/11/24.
//

import Foundation
import Domain


protocol GitHubRepositoryProtocol {
    func searchRepositories(query: String, page: Int) async throws -> [GitHubRepository]
}
