//
//  TopArtistPresentationItem.swift
//  ModuleTopArtists
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

struct TopArtistPresentationItem: TopArtistPresentable {
    let artist: ArtistType

    var attributedName: NSAttributedString {
        return NSAttributedString(string: artist.name)
    }

    init(_ artist: ArtistType) {
        self.artist = artist
    }

    func asArtist() -> ArtistType {
        return artist
    }
}
