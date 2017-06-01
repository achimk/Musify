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

        /*
         Navigator
         */
        let navigator = ListNavigator()

        /*
         View -> Presenter -> Interactor
         */
        let view = ListViewController()

        let presenter = ListPresenter(navigator: navigator, outputs: view)

        let interactor = ListInteractor(outputs: presenter)

        /*
         Interactor -> Presenter -> View
         */
        view.presenter = presenter

        presenter.interactor = interactor

        return view
    }
}
