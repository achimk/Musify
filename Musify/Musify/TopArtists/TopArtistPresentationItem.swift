//
//  TopArtistPresentationItem.swift
//  Musify
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

protocol TopArtistPresentable: ArtistConvertible {
    var attributedName: NSAttributedString { get }
}

struct TopArtistPresentationItem {
    let artist: ArtistType

    init(artist: ArtistType) {
        self.artist = artist
    }
}

extension TopArtistPresentationItem: TopArtistPresentable {
    var attributedName: NSAttributedString {
        return NSAttributedString(string: artist.name)
    }

    func asArtist() -> ArtistType {
        return artist
    }
}
