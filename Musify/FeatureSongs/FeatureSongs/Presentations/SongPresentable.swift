//
//  SongPresentable.swift
//  FeatureSongs
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol SongPresentable {
    var attributedName: NSAttributedString { get }
    var attributedLength: NSAttributedString { get }
}
