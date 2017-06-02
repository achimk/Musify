//
//  TodoType.swift
//  MusTodo
//
//  Created by Joachim Kret on 01/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol TodoType {
    var identifier: String { get }
    var text: String { get }
    var done: Bool { get }
}

struct Todo: TodoType {
    var identifier: String
    var text: String
    var done: Bool

    init(identifier: String, text: String, done: Bool) {
        self.identifier = identifier
        self.text = text
        self.done = done
    }

    static func from(_ todo: TodoType) -> Todo {
        return Todo(
            identifier: todo.identifier,
            text: todo.text,
            done: todo.done
        )
    }
}
