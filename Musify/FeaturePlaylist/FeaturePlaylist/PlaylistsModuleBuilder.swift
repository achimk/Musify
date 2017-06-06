//
//  PlaylistsModuleBuilder.swift
//  FeaturePlaylist
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class PlaylistsModuleBuilder {

    init() {
        /*
         Inject additional dependencies here
         */
    }

    func build() -> UIViewController {

        /*
         Navigator
         */
        let navigator = PlaylistsNavigator()

        /*
         View -> Presenter -> Interactor
         */
        let view = PlaylistsViewController()

        let presenter = PlaylistsPresenter(navigator: navigator, outputs: view)

        let interactor = PlaylistsInteractor(outputs: presenter)

        /*
         Interactor -> Presenter -> View
         */
        view.presenter = presenter

        presenter.interactor = interactor

        return view
    }
}
