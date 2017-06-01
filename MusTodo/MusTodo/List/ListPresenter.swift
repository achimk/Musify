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

}

/**
 Outputs declarations here (ViewController)
 */
protocol ListPresenterOutputs: class {

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
        /*
         Inject additional dependencies here
         */
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
    /*
     Implement ListPresenterInputs protocol
     */
}

extension ListPresenter: ListInteractorOutputs {
    /*
     Implement ListInteractorOutputs protocol
     */
}
