//
//  AlbumPresentationItem.swift
//  FeatureAlbums
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

struct AlbumPresentationItem: AlbumPresentable {
    let album: AlbumType

    var attributedName: NSAttributedString {
        return NSAttributedString(string: album.name)
    }

    init(_ album: AlbumType) {
        self.album = album
    }

    func asAlbum() -> AlbumType {
        return album
    }
}
