//
//  ListInteractor.swift
//  MusTodo
//
//  Created by Joachim Kret on 01/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

/**
 Inputs declarations here (Interactor)
 */
protocol ListInteractorInputs: class {
    func add(withText text: String)
    func toggle(todo: TodoType)
//    func add(todo: TodoType)
//    func update(todo: TodoType)
//    func remove(todo: TodoType)
}

/**
 Outputs declarations here (Presenter)
 */
protocol ListInteractorOutputs: class {
    func all(todos elements: Array<TodoType>)
}

protocol ListInteractorType {
    var inputs: ListInteractorInputs { get }
    var outputs: ListInteractorOutputs? { get }
}

final class ListInteractor: ListInteractorType {
    var inputs: ListInteractorInputs { return self }
    weak var outputs: ListInteractorOutputs?

    fileprivate let service: TodoServiceType

    init(outputs: ListInteractorOutputs,
         service: TodoServiceType) {
        self.outputs = outputs
        self.service = service
    }

    deinit {
        print("['] \(type(of: self))")
    }
}

extension ListInteractor: ListInteractorInputs {
    func add(withText text: String) {
        add(todo: service.create(withText: text))
    }

    func toggle(todo: TodoType) {
        var todo = Todo.from(todo)
        todo.done = !todo.done
        update(todo: todo)
    }

    func add(todo: TodoType) {
        service.add(todo: todo)
        outputs?.all(todos: service.allTodos())
    }

    func update(todo: TodoType) {
        service.update(todo: todo)
        outputs?.all(todos: service.allTodos())
    }

    func remove(todo: TodoType) {
        service.remove(todo: todo)
        outputs?.all(todos: service.allTodos())
    }
}
