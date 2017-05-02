//
//  PlaylistsRoute.swift
//  Musify
//
//  Created by Joachim Kret on 01/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI
import MusServices

struct PlaylistsRoute: Routable {
    private let serviceNavigation: NavigationServiceType
    private let servicePlaylists: PlaylistServiceType

    init(serviceNavigation: NavigationServiceType,
         servicePlaylists: PlaylistServiceType) {

        self.serviceNavigation = serviceNavigation
        self.servicePlaylists = servicePlaylists
    }

    func navigate(to location: LocationType, using presenter: ViewControllerPresentable) throws {
        guard location.path == Navigation.Path.playlists.rawValue else { return }

        let flow = PlaylistsFlow(servicePlaylists: servicePlaylists)
        flow.present(using: presenter)
    }
}
