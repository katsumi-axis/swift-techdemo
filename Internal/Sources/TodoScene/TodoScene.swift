//
//  TodoScene.swift
//  Internal
//
//  Created by katsumi on 2024/11/24.
//

import SwiftUI
import ComposableArchitecture

public struct TodoScene: View {

    public init(store: StoreOf<TodoSceneReducer>) {
        self.store = store
    }
    let store: StoreOf<TodoSceneReducer>

    @State private var newTodo = ""
    
    public var body: some View {
        NavigationView {
            List {
                ForEach(store.todos) { todo in
                    HStack {
                        Button(action: {
                            store.send(.toggleTodo(id: todo.id))
                        }) {
                            Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                        }
                        Text(todo.title)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        store.send(.deleteTodo(from: index))
                    }
                })

                HStack {
                    TextField("新しいTodo", text: $newTodo)
                    Button(action: {
                        store.send(.addTodo(title: newTodo))
                        newTodo = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newTodo.isEmpty)
                }
            }
            .navigationTitle("Todo List")
        }
    }
}
