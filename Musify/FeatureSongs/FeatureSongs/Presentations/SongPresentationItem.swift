//
//  SongPresentationItem.swift
//  FeatureSongs
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

struct SongPresentationItem: SongPresentable {
    let song: SongType

    init(_ song: SongType) {
        self.song = song
    }

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
