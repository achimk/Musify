//
//  TopArtistsModuleBuilder.swift
//  ModuleTopArtists
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

public final class TopArtistsModuleBuilder {
    private let dependencies: TopArtistsModuleDependencies

    public init(_ dependencies: TopArtistsModuleDependencies) {
        self.dependencies = dependencies
    }

    public func build(_ navigator: TopArtistsNavigatorType? = nil) -> UIViewController {

        /*
         Navigator
         */
        let navigator = navigator ?? TopArtistsNavigator { _ in }

        /*
         View -> Presenter -> Interactor
         */
        let view = TopArtistsViewController()

        let presenter = TopArtistsPresenter(navigator: navigator, outputs: view)

        let interactor = TopArtistsInteractor(outputs: presenter, service: dependencies)

        /*
         Interactor -> Presenter -> View
         */
        view.presenter = presenter

        presenter.interactor = interactor

        return view
    }
}
