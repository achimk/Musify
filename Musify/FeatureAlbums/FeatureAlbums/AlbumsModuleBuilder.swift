//
//  AlbumsModuleBuilder.swift
//  FeatureAlbums
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

public final class AlbumsModuleBuilder {
    private let dependencies: AlbumsModuleDependencies

    public init(_ dependencies: AlbumsModuleDependencies) {
        self.dependencies = dependencies
    }

    public func build(_ navigator: AlbumsNavigatorType? = nil) -> UIViewController {

        /*
         Navigator
         */
        let navigator = navigator ?? AlbumsNavigator { _ in }

        /*
         View -> Presenter -> Interactor
         */
        let view = AlbumsViewController()

        let presenter = AlbumsPresenter(navigator: navigator, outputs: view)

        let interactor = AlbumsInteractor(
            outputs: presenter,
            artist: dependencies.artist,
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
