//
//  PlaylistPresentable.swift
//  FeaturePlaylist
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

protocol PlaylistPresentable: PlaylistConvertible {
    var attributedName: NSAttributedString { get }
}
