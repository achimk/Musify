//
//  MusicService.swift
//  MusServices
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

public struct MusicService {
    public init() { }
}

extension MusicService: ArtistsServiceType {
    public func topArtists() -> Observable<Array<ArtistType>> {
        let artists: Array<ArtistType> = [
            Artist(name: "The Chemical Brothers"),
            Artist(name: "Hans Zimmer"),
            Artist(name: "Miles Davis"),
            Artist(name: "Nine Inch Nails"),
            Artist(name: "Amon Tobin"),
            Artist(name: "Massive Attack"),
            Artist(name: "Gorillaz"),
            Artist(name: "Aphex Twin"),
            Artist(name: "Depeche Mode"),
            Artist(name: "The Police")
        ]
        return Observable.just(artists)
    }
}

extension MusicService: AlbumsServiceType {
    public func albums(fromArtist artist: ArtistType) -> Observable<Array<AlbumType>> {
        let count: Int = Int(arc4random_uniform(10)) + 1
        var albums: Array<AlbumType> = []
        for index in 0 ..< count {
            albums.append(
                Album(name: "Album \(index + 1)")
            )
        }

        return Observable.just(albums)
    }
}

extension MusicService: SongsServiceType {
    public func songs(fromAlbum album: AlbumType) -> Observable<Array<SongType>> {
        let count: Int = Int(arc4random_uniform(16)) + 1
        var songs: Array<SongType> = []
        for index in 0 ..< count {
            let length: UInt = max(UInt(arc4random_uniform(360)), 10)
            songs.append(
                Song(name: "Song \(index + 1)", length: length)
            )
        }

        return Observable.just(songs)
    }
}
