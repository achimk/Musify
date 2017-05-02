//
//  Services.swift
//  Musify
//
//  Created by Joachim Kret on 27/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

protocol ServicesType {
    var playlists: PlaylistServiceType { get }
    var artists: ArtistsServiceType { get }
    var albums: AlbumsServiceType { get }
    var songs: SongsServiceType { get }
}

struct Services: ServicesType {
    let playlists: PlaylistServiceType
    let artists: ArtistsServiceType
    let albums: AlbumsServiceType
    let songs: SongsServiceType

    init () {
        let musicService = MusicService()
        self.playlists = musicService
        self.artists = musicService
        self.albums = musicService
        self.songs = musicService
    }
}
