//
//  ListModuleBuilder.swift
//  MusTodo
//
//  Created by Joachim Kret on 01/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class ListModuleBuilder {

    init() {
        /*
         Inject additional dependencies here
         */
    }

    func build() -> UIViewController {

        // Dependencies
        let service = InMemoryTodoService()
        (0 ..< 5).forEach { (index) in
            let todo = service.create(withText: "Todo task (\(index + 1))")
            service.add(todo: todo)
        }


        /*
         Navigator
         */
        let navigator = ListNavigator()

        /*
         View -> Presenter -> Interactor
         */
        let view = ListViewController()

        let presenter = ListPresenter(navigator: navigator, outputs: view)

        let interactor = ListInteractor(
            outputs: presenter,
            service: service
        )

        /*
         Interactor -> Presenter -> View
         */
        view.presenter = presenter

        presenter.interactor = interactor

        return view
    }
}
