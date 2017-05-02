//
//  Router.swift
//  MusUI
//
//  Created by Joachim Kret on 23/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

// MARK: Routable

public protocol Routable {
    func navigate(to location: LocationType, using presenter: ViewControllerPresentable) throws
}

// MARK: ErrorRoutable

public protocol ErrorRoutable {
    func handle(routeError error: RouteError, using presenter: ViewControllerPresentable)
}

// MARK: Router

public struct Router: Routable {
    public var routes = Dictionary<String, Routable>()
    public var errorRouteHandler: ErrorRoutable?

    // MARK: Init

    public init() { }

    // MARK: Navigate

    public func navigate(to location: LocationType, using presenter: ViewControllerPresentable) {
        guard let route = routes[location.path] else {
            errorRouteHandler?.handle(routeError: RouteError.notFound(location), using: presenter)
            return
        }

        do {
            try route.navigate(to: location, using: presenter)
        } catch let error as RouteError {
            errorRouteHandler?.handle(routeError: error, using: presenter)
        } catch let error {
            errorRouteHandler?.handle(routeError: RouteError.unknown(location, error), using: presenter)
        }
    }
}
