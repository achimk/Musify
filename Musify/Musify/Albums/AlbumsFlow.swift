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

struct AlbumsEvent {
    enum Input {
        case request
        case select(album: AlbumType)
    }

    enum Output {
        case present(albums: Array<AlbumPresentable>)
    }
}

typealias AlbumsEventsCenter = EventsCoordinatorCenter<AlbumsEvent.Input, AlbumsEvent.Output>

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
        center.inputs.listen { (event) in
            print("input: \(event)")
        }

        center.outputs.listen { (event) in
            print("output: \(event)")
        }

        let navigator = serviceNavigation
        center.inputs.handle { (event) -> Bool in
            switch event {
            case .select(let album):
                let route = Navigation.Route.songs(album: album)
                let location = Navigation.Location.create(route)
                navigator.open(location, presenter: presenter)
                return true
            default:
                return false
            }
        }

        let interactor = AlbumsInteractor(
            service: serviceAlbums,
            artist: artist,
            listener: center.outputs.asListener()
        )

        // Create seperated handler to prevent release interactor by capture strong reference
        let interactorHandler = EventCallbackHandler { interactor.handle($0) }.asHandler()
        center.inputs.append(handler: interactorHandler)

        let controller = AlbumsViewController(
            center: center
        )
        controller.title = "Albums"
        center.outputs.append(handler: controller)

        presenter.present(viewController: controller)
    }
}
