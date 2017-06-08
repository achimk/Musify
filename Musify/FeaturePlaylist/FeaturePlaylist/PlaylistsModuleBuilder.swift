//
//  PlaylistsModuleBuilder.swift
//  FeaturePlaylist
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

public final class PlaylistsModuleBuilder {
    private let dependencies: PlaylistsModuleDependencies

    public init(_ dependencies: PlaylistsModuleDependencies) {
        self.dependencies = dependencies
    }

    public func build() -> UIViewController {

        /*
         Navigator
         */
        let navigator = PlaylistsNavigator()

        /*
         View -> Presenter -> Interactor
         */
        let view = PlaylistsViewController()

        let presenter = PlaylistsPresenter(navigator: navigator, outputs: view)

        let interactor = PlaylistsInteractor(outputs: presenter, service: dependencies)

        /*
         Interactor -> Presenter -> View
         */
        view.presenter = presenter

        presenter.interactor = interactor

        return view
    }
}
