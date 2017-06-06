//
//  AlbumsFeature.swift
//  Musify
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI
import MusServices
import FeatureAlbums

struct AlbumsFeature: FlowPresentable {
    private let serviceNavigation: NavigationServiceType
    private let serviceAlbums: AlbumsServiceType
    private let artist: ArtistType

    init(serviceNavigation: NavigationServiceType,
         serviceAlbums: AlbumsServiceType,
         artist: ArtistType) {

        self.serviceNavigation = serviceNavigation
        self.serviceAlbums = serviceAlbums
        self.artist = artist
    }

    func present(using presenter: ViewControllerPresentable) {
        let serviceNavigation = self.serviceNavigation
        let navigator = AlbumsNavigator { route in
            switch route {
            case .album(let album):
                let route = Navigation.Route.songs(album: album)
                let location = Navigation.Location.create(route)
                serviceNavigation.open(location, presenter: presenter)
            }
        }

        let dependencies: AlbumsModuleDependencies
        dependencies.artist = artist
        dependencies.service = serviceAlbums

        let controller = AlbumsModuleBuilder(dependencies).build(navigator)

        controller.title = "Albums"
        presenter.present(viewController: controller)
    }
}
