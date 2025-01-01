//
//  TodoRepository.swift
//  Internal
//
//  Created by axis on 2025/01/01.
//

import Foundation
import SQLite
import Domain

typealias Expression = SQLite.Expression

public class TodoRepository {

    private let db: Connection

    private let todos = Table("todos")
    private let id = Expression<String>("id")
    private let title = Expression<String>("title")
    private let isDone = Expression<Bool>("isDone")
    private let timestamp = Expression<Date>("timestamp")

    public init() throws {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw NSError(domain: "TodoApp", code: 1, userInfo: [NSLocalizedDescriptionKey: "ドキュメントディレクトリにアクセスできません。"])
        }

        let dbPath = documentDirectory.appendingPathComponent("todo.db").path
        db = try Connection(dbPath)
        try createTableIfNeeded()
    }

    private func createTableIfNeeded() throws {
        try db.run(todos.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(title)
            t.column(isDone)
            t.column(timestamp)
        })
    }

    public func addTodo(todo: TodoItem) throws {
        let insert = todos.insert(
            id <- todo.id.uuidString,
            title <- todo.title,
            isDone <- todo.isDone,
            timestamp <- todo.timestamp
        )
        try db.run(insert)
    }

    public func getAllTodos() throws -> [TodoItem] {
        return try db.prepare(todos).map { row in
            TodoItem(
                id: UUID(uuidString: row[id])!,
                title: row[title],
                isDone: row[isDone],
                timestamp: row[timestamp]
            )
        }
    }

    public func updateTodo(todo: TodoItem) throws {
        let targetTodo = todos.filter(id == todo.id.uuidString)
        let update = targetTodo.update(
            title <- todo.title,
            isDone <- todo.isDone,
            timestamp <- todo.timestamp
        )
        try db.run(update)
    }

    public func deleteTodo(id: UUID) throws {
        let targetTodo = todos.filter(self.id == id.uuidString)
        try db.run(targetTodo.delete())
    }
}
