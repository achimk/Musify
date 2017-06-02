//
//  TodoServiceType.swift
//  MusTodo
//
//  Created by Joachim Kret on 01/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol TodoServiceType {
    func allTodos() -> Array<TodoType>
    func create(withText text: String) -> TodoType
    func add(todo: TodoType)
    func update(todo: TodoType)
    func remove(todo: TodoType)
}

final class InMemoryTodoService: TodoServiceType {
    private var todos: Array<TodoType> = []

    init() { }

    func allTodos() -> Array<TodoType> {
        return todos
    }

    func create(withText text: String) -> TodoType {
        return Todo(
            identifier: UUID().uuidString,
            text: text,
            done: false
        )
    }

    func add(todo: TodoType) {
        if !contains(todo) {
            todos.append(todo)
        }
    }

    func update(todo: TodoType) {
        if let index = index(of: todo) {
            todos[index] = todo
        } else {
            todos.append(todo)
        }
    }

    func remove(todo: TodoType) {
        if let index = index(of: todo) {
            todos.remove(at: index)
        }
    }

    private func contains(_ todo: TodoType) -> Bool {
        return index(of: todo) != nil
    }

    private func index(of todo: TodoType) -> Int? {
        for (offset, element) in todos.enumerated() {
            if element.identifier == todo.identifier {
                return offset
            }
        }

        return nil
    }
}
