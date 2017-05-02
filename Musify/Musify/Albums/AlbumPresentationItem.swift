//
//  AlbumPresentationItem.swift
//  Musify
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

protocol AlbumPresentable: AlbumConvertible {
    var attributedName: NSAttributedString { get }
}

struct AlbumPresentationItem {
    let album: AlbumType

    init(album: AlbumType) {
        self.album = album
    }
}

extension AlbumPresentationItem: AlbumPresentable {
    var attributedName: NSAttributedString {
        return NSAttributedString(string: album.name)
    }

    func asAlbum() -> AlbumType {
        return album
    }
}
