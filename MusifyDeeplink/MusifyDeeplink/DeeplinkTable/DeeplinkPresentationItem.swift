//
//  DeeplinkPresentationItem.swift
//  MusifyDeeplink
//
//  Created by Joachim Kret on 08/04/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol DeeplinkPresentable {
    var attributedName: NSAttributedString { get }
}

struct DeeplinkPresentationItem {
    fileprivate let deeplink: DeeplinkType

    init(_ deeplink: DeeplinkType) {
        self.deeplink = deeplink
    }
}

extension DeeplinkPresentationItem: DeeplinkPresentable {
    var attributedName: NSAttributedString {
        return NSAttributedString(string: deeplink.name)
    }
}
