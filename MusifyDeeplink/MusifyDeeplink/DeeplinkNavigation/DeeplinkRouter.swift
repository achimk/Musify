//
//  DeeplinkRouter.swift
//  MusifyDeeplink
//
//  Created by Joachim Kret on 08/04/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol DeeplinkRoutable {
    func open(_ url: URL)
}

struct DeeplinkRouter: DeeplinkRoutable {
    private let handler: ((URL) -> Void)

    init(handler: @escaping ((URL) -> Void)) {
        self.handler = handler
    }

    func open(_ url: URL) {
        handler(url)
    }
}
