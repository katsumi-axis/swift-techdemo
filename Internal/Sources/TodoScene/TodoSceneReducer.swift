import Combine
import ComposableArchitecture
import Domain
import Foundation
import Repository

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
        case onTodosLoaded(Result<[TodoItem], Error>)
        case addTodo(title: String)
        case deleteTodo(id: UUID)
        case toggleTodo(id: UUID)
    }

    public func reduce(into state: inout State, action: Action) -> Effect<
        Action
    > {
        switch action {
        case .onAppear:
            return .run { send in
                do {
                    let repository = try TodoRepository()
                    let results = try repository.getAllTodos()
                    await send(.onTodosLoaded(.success(results)))
                } catch {
                    await send(.onTodosLoaded(.failure(error)))
                }
            }
        case .onTodosLoaded(.success(let todos)):
            state.todos = todos
            return .none
        case .onTodosLoaded(.failure(let error)):
            print("Error loading todos: \(error)")
            return .none
        case .addTodo(let title):
            let todo = TodoItem(title: title)
            state.todos.append(todo)
            do {
                let repository = try TodoRepository()
                try repository.addTodo(todo: todo)
            } catch {
                print("Error initializing TodoManager: \(error)")
            }
            return .none
        case .deleteTodo(let id):
            state.todos.removeAll(where: { $0.id == id })
            do {
                let repository = try TodoRepository()
                try repository.deleteTodo(id: id)
            } catch {
                print("Error deleting todo: \(error)")
            }
            return .none
        case .toggleTodo(let id):
            guard let index = state.todos.firstIndex(where: { $0.id == id })
            else { return .none }
            state.todos[index].isDone.toggle()
            let updatedTodo = state.todos[index]
            do {
                let repository = try TodoRepository()
                try repository.updateTodo(todo: updatedTodo)
            } catch {
                print("Error initializing TodoManager: \(error)")
            }
            return .none
        }
    }
}
