import Combine
import Foundation
import ComposableArchitecture
import Domain
import Repository
import SwiftData

@Model
final class TodoItem: Identifiable {
    @Attribute(.unique) var id: UUID
    var title: String
    var isDone: Bool
    var timestamp: Date

    init(id: UUID = UUID(), title: String, isDone: Bool = false, timestamp: Date = .now) {
        self.id = id
        self.title = title
        self.isDone = isDone
        self.timestamp = timestamp
    }
}

@Reducer
public struct TodoSceneReducer: Reducer, Sendable {
    public init() {}

    @ObservableState
    public struct State {
        public init() {}

        var todos: [TodoItem] = []
    }

    public enum Action {
        case onAppear
        case addTodo(title: String)
        case deleteTodo(from: Int)
        case toggleTodo(id: UUID)
    }

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
        case .addTodo(let title):
            let todo = TodoItem(id: UUID(), title: title, isDone: false, timestamp: Date())
            state.todos.append(todo)
            return .none
            
        case .deleteTodo(let index):
            state.todos.remove(at: index)
            return .none
        case .toggleTodo(let id): // 追加: toggleTodoアクションの処理
                 if let index = state.todos.firstIndex(where: { $0.id == id }) {
                     state.todos[index].isDone.toggle()
                 }
                 return .none
        }
    }
}
