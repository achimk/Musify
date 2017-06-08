//
//  PlaylistPresentationItem.swift
//  FeaturePlaylist
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

struct PlaylistPresentationItem: PlaylistPresentable {
    let playlist: PlaylistType

    init(_ playlist: PlaylistType) {
        self.playlist = playlist
    }

    var attributedName: NSAttributedString {
        return NSAttributedString(string: playlist.name)
    }

    func asPlaylist() -> PlaylistType {
        return playlist
    }
}
