//
//  TopArtistsFeature.swift
//  Musify
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI
import MusServices
import FeatureTopArtists

struct TopArtistsFeature: FlowPresentable {
    let serviceNavigation: NavigationServiceType
    let serviceArtists: ArtistsServiceType

    init(serviceNavigation: NavigationServiceType,
         serviceArtists: ArtistsServiceType) {

        self.serviceNavigation = serviceNavigation
        self.serviceArtists = serviceArtists
    }

    func present(using presenter: ViewControllerPresentable) {
        let serviceNavigation = self.serviceNavigation
        let dependencies: TopArtistsModuleDependencies = serviceArtists
        let navigator = TopArtistsNavigator { route in
            switch route {
            case .artist(let artist):
                let route = Navigation.Route.albums(artist: artist)
                let location = Navigation.Location.create(route)
                serviceNavigation.open(location, presenter: presenter)
            }
        }

        let controller = TopArtistsModuleBuilder(dependencies).build(navigator)
        controller.title = "Artists"
        presenter.present(viewController: controller)
    }
}
