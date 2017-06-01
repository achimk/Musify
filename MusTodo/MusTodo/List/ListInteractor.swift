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

}

/**
 Outputs declarations here (Presenter)
 */
protocol ListInteractorOutputs: class {

}

protocol ListInteractorType {
    var inputs: ListInteractorInputs { get }
    var outputs: ListInteractorOutputs? { get }
}

final class ListInteractor: ListInteractorType {
    var inputs: ListInteractorInputs { return self }
    weak var outputs: ListInteractorOutputs?

    init(outputs: ListInteractorOutputs) {
        self.outputs = outputs
        /*
         Inject additional dependencies here
         */
    }

    deinit {
        print("['] \(type(of: self))")
    }
}

extension ListInteractor: ListInteractorInputs {
    /*
     Implement ListInteractorInputs protocol
     */
}
