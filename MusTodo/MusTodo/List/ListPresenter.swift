//
//  ListPresenter.swift
//  MusTodo
//
//  Created by Joachim Kret on 01/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol ListPresenterAppearance {
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

/**
 Inputs declarations here (Presenter)
 */
protocol ListPresenterInputs: class, ListPresenterAppearance {
    func reload()
    func add(withText text: String)
}

/**
 Outputs declarations here (ViewController)
 */
protocol ListPresenterOutputs: class {
//    func present(items: Array<TodoItemPresentable>)
    func present(viewModels: Array<TodoViewModelType>)
}

protocol ListPresenterType {
    var inputs: ListPresenterInputs { get }
    var outputs: ListPresenterOutputs? { get }
}

final class ListPresenter: ListPresenterType {
    let navigator: ListNavigatorType
    var interactor: ListInteractorInputs!
    var inputs: ListPresenterInputs { return self }
    weak var outputs: ListPresenterOutputs?

    init(navigator: ListNavigatorType,
         outputs: ListPresenterOutputs) {

        self.navigator = navigator
        self.outputs = outputs
    }

    deinit {
        print("['] \(type(of: self))")
    }
}

extension ListPresenter: ListPresenterAppearance {
    func viewDidLoad() {
    }

    func viewWillAppear(_ animated: Bool) {
    }

    func viewDidAppear(_ animated: Bool) {
    }

    func viewWillDisappear(_ animated: Bool) {
    }

    func viewDidDisappear(_ animated: Bool) {
    }
}

extension ListPresenter: ListPresenterInputs {
    func add(withText text: String) {
        interactor.add(withText: text)
    }

    func reload() {
        interactor.reload()
    }
}

extension ListPresenter: ListInteractorOutputs {
    func all(models: Array<TodoModelType>) {
        let viewModels = models.map { TodoViewModel(model: $0) }
        outputs?.present(viewModels: viewModels)
    }
}
