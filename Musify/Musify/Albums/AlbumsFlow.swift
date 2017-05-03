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
    private let center = AlbumsEventsCenter()

    init(serviceNavigation: NavigationServiceType,
         serviceAlbums: AlbumsServiceType,
         artist: ArtistType) {

        self.serviceNavigation = serviceNavigation
        self.serviceAlbums = serviceAlbums
        self.artist = artist
    }

    func present(using presenter: ViewControllerPresentable) {
        let flow = self

        center.handlers.create(input: { (event) -> Bool in
            print("handle input: \(event)")
            return false
        })

        center.handlers.create(output: { (event) -> Bool in
            print("handle output: \(event)")
            return false
        })

        center.handlers.create(input: { (event) -> Bool in
            switch event {
            case .select(let album):
                let route = Navigation.Route.songs(album: album)
                let location = Navigation.Location.create(route)
                flow.serviceNavigation.open(location, presenter: presenter)
                
                return true
            default:
                return false
            }
        })


        let controller = AlbumsViewController(service: serviceAlbums, artist: artist, eventsHandler: center)
        controller.title = "Albums"
        presenter.present(viewController: controller)
    }
}
