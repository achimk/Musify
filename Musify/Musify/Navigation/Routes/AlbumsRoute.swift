//
//  AlbumsRoute.swift
//  Musify
//
//  Created by Joachim Kret on 23/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI
import MusServices

struct AlbumsRoute: Routable {
    private let serviceNavigation: NavigationServiceType
    private let serviceAlbums: AlbumsServiceType

    init(serviceNavigation: NavigationServiceType,
         serviceAlbums: AlbumsServiceType) {
        
        self.serviceNavigation = serviceNavigation
        self.serviceAlbums = serviceAlbums
    }

    func navigate(to location: LocationType, using presenter: ViewControllerPresentable) {
        guard location.path == Navigation.Path.albums.rawValue else { return }
        guard let name = location.arguments["artist"] else { return }

        let artist = Artist(name: name)
        let flow = AlbumsFeature(
            serviceNavigation: serviceNavigation,
            serviceAlbums: serviceAlbums,
            artist: artist
        )

        flow.present(using: presenter)
    }
}
