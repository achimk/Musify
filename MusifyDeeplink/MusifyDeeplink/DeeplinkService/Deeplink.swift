//
//  Deeplink.swift
//  MusifyDeeplink
//
//  Created by Joachim Kret on 08/04/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol DeeplinkType {
    var name: String { get }
    var url: URL { get }
}

struct Deeplink: DeeplinkType {
    let name: String
    let url: URL

    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}
