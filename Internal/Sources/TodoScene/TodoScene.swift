//
//  TodoScene.swift
//  Internal
//
//  Created by katsumi on 2024/11/24.
//

import SwiftUI

public struct TodoScene: View {
    @State private var todos = [
        "SwiftUIを学ぶ",
        "アプリを作る",
        "コードをGitHubに上げる"
    ]
    @State private var newTodo = ""
    
    public init() {}
    public var body: some View {
        NavigationView {
            List {
                ForEach(todos, id: \.self) { todo in
                    Text(todo)
                }
                .onDelete(perform: deleteTodo)
                
                HStack {
                    TextField("新しいTodo", text: $newTodo)
                    Button(action: addTodo) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .navigationTitle("Todo List")
        }
    }
    
    func addTodo() {
        if !newTodo.isEmpty {
            todos.append(newTodo)
            newTodo = ""
        }
    }
    
    func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}
