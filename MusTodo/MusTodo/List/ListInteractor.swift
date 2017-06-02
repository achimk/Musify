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
    func reload()
}

/**
 Outputs declarations here (Presenter)
 */
protocol ListInteractorOutputs: class {
    func all(models: Array<TodoModelType>)
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

    func reload() {
        let todos = service.allTodos()
        let models = convert(todos: todos)
        output(models: models)
    }

    private func add(todo: TodoType) {
        service.add(todo: todo)
        reload()
    }

    private func update(todo: TodoType) {
        service.update(todo: todo)
        reload()
    }

    private func remove(todo: TodoType) {
        service.remove(todo: todo)
        reload()
    }

    private func convert(todos: Array<TodoType>) -> Array<TodoModelType> {
        let service = self.service
        return todos.map { TodoModel(todo: $0, service: service) }
    }

    private func output(models: Array<TodoModelType>) {
        outputs?.all(models: models)
    }
}
