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


