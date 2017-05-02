//
//  Navigation.swift
//  Musify
//
//  Created by Joachim Kret on 29/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI
import MusServices

struct Navigation {
    static var Scheme: String = "musify"

    enum Path: String {
        case playlists = "playlists"
        case topArtists = "top_artists"
        case albums = "albums:{artist}"
        case songs = "songs:{album}"
    }

    enum Route {
        case playlists
        case topArtists
        case albums(artist: ArtistType)
        case songs(album: AlbumType)
    }

    struct Location: LocationType {
        var scheme: String {
            return Navigation.Scheme
        }

        let path: String
        let arguments: Dictionary<String, String>
        let payload: Optional<Any>

        init(path: String,
             arguments: Dictionary<String, String> = [:],
             payload: Any? = nil) {

            self.path = path
            self.arguments = arguments
            self.payload = payload
        }

        static func create(_ route: Route) -> Location {
            switch route {
            case .playlists:
                return Location(path: Path.playlists.rawValue)

            case .topArtists:
                return Location(path: Path.topArtists.rawValue)

            case .albums(let artist):
                return Location(
                    path: Path.albums.rawValue,
                    arguments: ["artist" : artist.name],
                    payload: artist
                )

            case .songs(let album):
                return Location(
                    path: Path.songs.rawValue,
                    arguments: ["album" : album.name],
                    payload: album
                )
            }
        }
    }
}
