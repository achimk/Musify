//
//  TodoViewModel.swift
//  MusTodo
//
//  Created by Joachim Kret on 02/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

protocol TodoViewModelInputs {
    func toggle()
}

protocol TodoViewModelOutputs {
    func onUpdateText() -> Observable<NSAttributedString>
    func onUpdateDone() -> Observable<Bool>
}

protocol TodoViewModelType {
    var inputs: TodoViewModelInputs { get }
    var outputs: TodoViewModelOutputs { get }
}

final class TodoViewModel: TodoViewModelType {
    fileprivate let model: TodoModelType
    fileprivate let inputText: Variable<String>
    fileprivate let inputDone: Variable<Bool>

    var inputs: TodoViewModelInputs { return self }
    var outputs: TodoViewModelOutputs { return self }

    init(model: TodoModelType) {
        let todo = model.asTodo()
        self.inputText = Variable(todo.text)
        self.inputDone = Variable(todo.done)
        self.model = model
        self.model.outputs = self
    }
}

extension TodoViewModel: TodoModelOutputs {
    func updated(todo: TodoType) {
        inputText.value = todo.text
        inputDone.value = todo.done
    }
}

extension TodoViewModel: TodoViewModelInputs {
    func toggle() {
        model.inputs.toggle()
    }
}

extension TodoViewModel: TodoViewModelOutputs {
    func onUpdateText() -> Observable<NSAttributedString> {
        return inputText.asObservable().map { NSAttributedString(string: $0) }
    }

    func onUpdateDone() -> Observable<Bool> {
        return inputDone.asObservable()
    }
}
