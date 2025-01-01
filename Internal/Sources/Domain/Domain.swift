//
//  Domain.swift
//  Internal
//
//  Created by katsumi on 2024/11/24.
//

import Foundation
import SwiftData

public struct GitHubRepo: Codable {
    public let id: Int
    public let name: String
    public let url: String
    public let stargazers_count: Int16
    public let watchers_count: Int16
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case stargazers_count
        case watchers_count
    }
}


@Model
public final class TodoItem: Identifiable, Equatable {
    public var id: UUID
    public var title: String
    public var isDone: Bool
    public var timestamp: Date

    public init(id: UUID = UUID(), title: String, isDone: Bool = false, timestamp: Date = .now) {
        self.id = id
        self.title = title
        self.isDone = isDone
        self.timestamp = timestamp
    }

    public static func == (lhs: TodoItem, rhs: TodoItem) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.isDone == rhs.isDone &&
               lhs.timestamp == rhs.timestamp
    }
}

