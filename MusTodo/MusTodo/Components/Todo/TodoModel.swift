//
//  TodoModel.swift
//  MusTodo
//
//  Created by Joachim Kret on 02/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol TodoModelInputs: class {
    func toggle()
}

protocol TodoModelOutputs: class {
    func updated(todo: TodoType)
}

protocol TodoModelType: TodoConvertible {
    var inputs: TodoModelInputs { get }
    var outputs: TodoModelOutputs? { set get }
}

final class TodoModel: TodoModelType {
    fileprivate var todo: TodoType
    fileprivate let service: TodoServiceType

    var inputs: TodoModelInputs { return self }
    weak var outputs: TodoModelOutputs?

    init(todo: TodoType, service: TodoServiceType) {
        self.todo = todo
        self.service = service
    }

    func asTodo() -> TodoType {
        return todo
    }
}

extension TodoModel: TodoModelInputs {
    func toggle() {
        var todo = Todo.from(self.todo)
        todo.done = !todo.done
        update(todo: todo)
    }

    private func update(todo: TodoType) {
        service.update(todo: todo)
        self.todo = todo
        outputs?.updated(todo: todo)
    }
}
