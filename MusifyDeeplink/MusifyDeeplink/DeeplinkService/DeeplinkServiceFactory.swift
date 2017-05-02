//
//  DeeplinkServiceFactory.swift
//  MusifyDeeplink
//
//  Created by Joachim Kret on 08/04/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct DeeplinkServiceFactory {
    static func create() -> DeeplinkServiceType {
        let topArtistsDeeplink = Deeplink(
            name: "Top Artists",
            url: URL(string: "musify://top_artists")!
        )

        let albumsDeeplink = Deeplink(
            name: "Albums",
            url: URL(string: "musify://albums:Unique_Artist_Name_Here")!
        )

        let songsDeeplink = Deeplink(
            name: "Songs",
            url: URL(string: "musify://songs:Unique_Album_Name_Here")!
        )

        return DeeplinkService(results: [
                topArtistsDeeplink,
                albumsDeeplink,
                songsDeeplink
            ])
    }
}
