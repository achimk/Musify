//
//  TodoPresentationItem.swift
//  MusTodo
//
//  Created by Joachim Kret on 01/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct TodoPresentationItem: TodoItemPresentable {
    private let todo: TodoType

    let attributedText: NSAttributedString
    let isDone: Bool

    init(_ todo: TodoType) {
        self.todo = todo
        self.attributedText = NSAttributedString(string: todo.text)
        self.isDone = todo.done
    }

    func asTodo() -> TodoType {
        return todo
    }
}
