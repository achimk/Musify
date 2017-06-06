//
//  SongsRoute.swift
//  Musify
//
//  Created by Joachim Kret on 23/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI
import MusServices

struct SongsRoute: Routable {
    private let serviceSongs: SongsServiceType

    init(serviceSongs: SongsServiceType) {
        self.serviceSongs = serviceSongs
    }

    func navigate(to location: LocationType, using presenter: ViewControllerPresentable) {
        guard location.path == Navigation.Path.songs.rawValue else { return }
        guard let name = location.arguments["album"] else { return }

        let album = Album(name: name)
        let flow = SongsFeature(serviceSongs: serviceSongs, album: album)
        flow.present(using: presenter)
    }
}
