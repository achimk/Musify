//
//  PlaylistPresentationItem.swift
//  Musify
//
//  Created by Joachim Kret on 01/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

protocol PlaylistPresentable: PlaylistConvertible {
    var attributedName: NSAttributedString { get }
}

struct PlaylistPresentationItem: PlaylistPresentable {
    let playlist: PlaylistType

    init(playlist: PlaylistType) {
        self.playlist = playlist
    }

    var attributedName: NSAttributedString {
        return NSAttributedString(string: playlist.name)
    }

    func asPlaylist() -> PlaylistType {
        return playlist
    }
}
