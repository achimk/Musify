//
//  NavigationServiceFactory.swift
//  Musify
//
//  Created by Joachim Kret on 29/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI

struct NavigationServiceFactory {
    static func create(by services: ServicesType) -> NavigationServiceType {
        let serviceNavigation = NavigationServiceProxy()
        var router = Router()

        router.routes[Navigation.Path.playlists.rawValue] = PlaylistsRoute(
            serviceNavigation: serviceNavigation,
            servicePlaylists: services.playlists)

        router.routes[Navigation.Path.topArtists.rawValue] = TopArtistsRoute(
            serviceNavigation: serviceNavigation,
            serviceArtists: services.artists
        )

        router.routes[Navigation.Path.albums.rawValue] = AlbumsRoute(
            serviceNavigation: serviceNavigation,
            serviceAlbums: services.albums
        )

        router.routes[Navigation.Path.songs.rawValue] = SongsRoute(
            serviceSongs: services.songs
        )

        serviceNavigation.navigator = NavigationService(router: router)

        return serviceNavigation
    }
}
