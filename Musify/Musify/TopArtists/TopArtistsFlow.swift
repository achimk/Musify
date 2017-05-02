//
//  TopArtistsFlow.swift
//  Musify
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import MusUI
import MusServices

struct TopArtistsFlow: FlowPresentable {
    let serviceNavigation: NavigationServiceType
    let serviceArtists: ArtistsServiceType

    init(serviceNavigation: NavigationServiceType,
         serviceArtists: ArtistsServiceType) {

        self.serviceNavigation = serviceNavigation
        self.serviceArtists = serviceArtists
    }

    func present(using presenter: ViewControllerPresentable) {
        let flow = self
        let controller = TopArtistsViewController(service: serviceArtists) { artist in
            let route = Navigation.Route.albums(artist: artist)
            let location = Navigation.Location.create(route)
            flow.serviceNavigation.open(location, presenter: presenter)
        }
        controller.title = "Artists"
        presenter.present(viewController: controller)
    }
}
