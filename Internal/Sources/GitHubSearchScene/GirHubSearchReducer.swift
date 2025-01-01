import Combine
import ComposableArchitecture
import Domain
import Repository
import SwiftUI

@Reducer
public struct GitHubSearchReducer: Reducer, Sendable {
    public init() {}

    @ObservableState
    public struct State {
        public init(
            query: String = "", repositories: [GitHubRepo] = [],
            isLoading: Bool = false
        ) {
            self.query = query
            self.repositories = repositories
            self.isLoading = isLoading
        }
        var query: String
        var repositories: [GitHubRepo]
        var isLoading: Bool
    }

    public enum GitHubSearchError: Error {
        case unknown
    }

    public enum Action {
        case queryChanged(String)
        case search
        case searchResponse(Result<[GitHubRepo], Error>)
    }

    @Dependency(\.continuousClock) var clock
    private enum CancelID { case debounce }

    public func reduce(into state: inout State, action: Action) -> Effect<
        Action
    > {
        switch action {

        case .queryChanged(let query):
            state.query = query
            return .none

        case .search:
            state.isLoading = true
            let query = state.query
            
            return .run { send in
                let repository = GitHubRepository()
                do {
                    let results = try await repository.searchRepositories(query: query)
                    await send(.searchResponse(.success(results)))
                } catch {
                    await send(.searchResponse(.failure(error)))
                }
            }

        case .searchResponse(.success(let repositories)):
            state.repositories = repositories
            state.isLoading = false
            return .none
        case .searchResponse(.failure(_)):
            state.isLoading = false
            // Handle the error if needed
            return .none
        }
    }
}
