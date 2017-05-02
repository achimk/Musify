//
//  SongPresentationItem.swift
//  Musify
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

protocol SongPresentable {
    var attributedName: NSAttributedString { get }
    var attributedLength: NSAttributedString { get }
}

struct SongPresentationItem {
    let song: SongType

    init(song: SongType) {
        self.song = song
    }
}

extension SongPresentationItem: SongPresentable {
    var attributedName: NSAttributedString {
        return NSAttributedString(string: song.name)
    }

    var attributedLength: NSAttributedString {
        let minutes: UInt = song.length / 60
        let seconds: UInt = song.length % 60

        let secondsString = (seconds < 10)
            ? String("0\(seconds)") ?? "00"
            : String("\(seconds)") ?? "00"

        let lengthString = String("\(minutes):\(secondsString)") ?? ""

        return NSAttributedString(string: lengthString)
    }
}
