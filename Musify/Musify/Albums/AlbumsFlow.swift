//
//  AlbumsFlow.swift
//  Musify
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import MusUI
import MusServices

struct AlbumsFlow: FlowPresentable {
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
        let flow = self
        let controller = AlbumsViewController(service: serviceAlbums, artist: artist) { album in
            let route = Navigation.Route.songs(album: album)
            let location = Navigation.Location.create(route)
            flow.serviceNavigation.open(location, presenter: presenter)
        }
        controller.title = "Albums"
        presenter.present(viewController: controller)
    }
}
