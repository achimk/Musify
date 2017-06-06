//
//  SongsModuleBuilder.swift
//  FeatureSongs
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

public final class SongsModuleBuilder {
    private let dependencies: SongsModuleDependencies

    public init(_ dependencies: SongsModuleDependencies) {
        self.dependencies = dependencies
    }

    public func build() -> UIViewController {

        /*
         Navigator
         */
        let navigator = SongsNavigator()

        /*
         View -> Presenter -> Interactor
         */
        let view = SongsViewController()

        let presenter = SongsPresenter(navigator: navigator, outputs: view)

        let interactor = SongsInteractor(
            outputs: presenter,
            album: dependencies.album,
            service: dependencies.service
        )

        /*
         Interactor -> Presenter -> View
         */
        view.presenter = presenter

        presenter.interactor = interactor

        return view
    }
}
