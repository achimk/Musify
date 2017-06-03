//
//  TodoPresentationItem.swift
//  MusTodo
//
//  Created by Joachim Kret on 03/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct TodoPresentationItem: TodoItemPresentable {
    private let todo: TodoType
    var attributedText: NSAttributedString { return NSAttributedString(string: todo.text) }
    var isDone: Bool { return todo.done }

    init(_ todo: TodoType) {
        self.todo = todo
    }

    func asTodo() -> TodoType {
        return todo
    }
}
