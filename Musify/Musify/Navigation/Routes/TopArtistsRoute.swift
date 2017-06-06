//
//  TopArtistsRoute.swift
//  Musify
//
//  Created by Joachim Kret on 27/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI
import MusServices

struct TopArtistsRoute: Routable {
    private let serviceNavigation: NavigationServiceType
    private let serviceArtists: ArtistsServiceType

    init(serviceNavigation: NavigationServiceType,
         serviceArtists: ArtistsServiceType) {

        self.serviceNavigation = serviceNavigation
        self.serviceArtists = serviceArtists
    }

    func navigate(to location: LocationType, using presenter: ViewControllerPresentable) {
        guard location.path == Navigation.Path.topArtists.rawValue else { return }

        let flow = TopArtistsFeature(
            serviceNavigation: serviceNavigation,
            serviceArtists: serviceArtists
        )

        flow.present(using: presenter)
    }
}
