//
//  Domain.swift
//  Internal
//
//  Created by katsumi on 2024/11/24.
//


public struct GitHubRepository: Codable, Sendable {
    public let id: Int
    public let name: String
    public let description: String?
    public let url: String
    public let stargazersCount: Int
    public let owner: GithubOwner
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case url = "html_url"
        case stargazersCount = "stargazers_count"
        case owner
    }
}

public extension GitHubRepository {
    static let mockData: [GitHubRepository] = [
        GitHubRepository(
            id: 1,
            name: "SwiftUI-App",
            description: "A demo app using SwiftUI",
            url: "https://github.com/user/SwiftUI-App",
            stargazersCount: 150,
            owner: GithubOwner(login: "user", avatarUrl: "https://github.com/user.png")
        ),
        GitHubRepository(
            id: 2,
            name: "iOS-Learning",
            description: "Resources for learning iOS development",
            url: "https://github.com/user/iOS-Learning",
            stargazersCount: 200,
            owner: GithubOwner(login: "user", avatarUrl: "https://github.com/user.png")
        ),
        GitHubRepository(
            id: 3,
            name: "Swift-Examples",
            description: "Examples of Swift code",
            url: "https://github.com/user/Swift-Examples",
            stargazersCount: 300,
            owner: GithubOwner(login: "user", avatarUrl: "https://github.com/user.png")
        )
    ]
}

public struct GithubOwner: Codable, Sendable {
    public let login: String
    public let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}


public struct Todo: Codable {
    let id: Int
    let title: String
    let isDone: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case isDone
    }
}
