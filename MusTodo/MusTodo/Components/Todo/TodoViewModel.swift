//
//  TodoViewModel.swift
//  MusTodo
//
//  Created by Joachim Kret on 02/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol TodoViewModelInputs: class {
    func toggle()
}

protocol TodoViewModelOutputs: class {
    var update: ((TodoItemPresentable) -> Void) { set get }
}

protocol TodoViewModelType {
    var inputs: TodoViewModelInputs { get }
    var outputs: TodoViewModelOutputs { get }
}

final class TodoViewModel: TodoViewModelType {
    fileprivate let model: TodoModelType
    fileprivate var item: TodoItemPresentable? {
        didSet {
            updateIfNeeded()
        }
    }

    var inputs: TodoViewModelInputs { return self }
    var outputs: TodoViewModelOutputs { return self }

    var update: ((TodoItemPresentable) -> Void) {
        didSet {
            updateIfNeeded()
        }
    }

    init(model: TodoModelType) {
        self.update = { _ in }
        self.model = model
        self.model.outputs = self
    }
}

extension TodoViewModel: TodoViewModelInputs {
    func toggle() {
        model.inputs.toggle()
    }
}

extension TodoViewModel: TodoViewModelOutputs {
}

extension TodoViewModel: TodoModelOutputs {
    func update(_ todo: TodoType) {
        item = TodoPresentationItem(todo)
    }
}

extension TodoViewModel {
    fileprivate func updateIfNeeded() {
        if let item = item { update(item) }
    }
}
