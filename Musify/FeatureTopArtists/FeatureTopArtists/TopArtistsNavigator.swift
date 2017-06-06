//
//  TopArtistsNavigator.swift
//  ModuleTopArtists
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

public enum Route {
    case artist(ArtistType)
}

/**
 Inputs declarations here (Presenter)
 */
public protocol TopArtistsNavigatorType: class {
    func present(artist: ArtistType)
}

public final class TopArtistsNavigator: TopArtistsNavigatorType {
    private let routerCallback: ((Route) -> Void)

    public init(_ routerCallback: @escaping ((Route) -> Void)) {
        self.routerCallback = routerCallback
    }

    deinit {
        print("['] \(type(of: self))")
    }

    public func present(artist: ArtistType) {
        routerCallback(.artist(artist))
    }
}
