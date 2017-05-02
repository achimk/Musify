//
//  NavigationService.swift
//  Musify
//
//  Created by Joachim Kret on 23/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusUI

struct NavigationService: NavigationServiceType {
    private let navigator: Navigator
    private let router: Router

    init(router: Router) {
        var navigator = Navigator(scheme: "musify")
        navigator.routes = Array(router.routes.keys)
        self.navigator = navigator
        self.router = router
    }

    func open(_ url: URL, presenter: ViewControllerPresentable) {
        if let location = navigator.parse(url: url) {
            open(location, presenter: presenter)
        }
    }

    func open(_ location: LocationType, presenter: ViewControllerPresentable) {
        router.navigate(to: location, using: presenter)
    }
}

final class NavigationServiceProxy: NavigationServiceType {
    var navigator: NavigationServiceType? = nil

    func open(_ url: URL, presenter: ViewControllerPresentable) {
        navigator?.open(url, presenter: presenter)
    }

    func open(_ location: LocationType, presenter: ViewControllerPresentable) {
        navigator?.open(location, presenter: presenter)
    }
}
