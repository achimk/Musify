//
//  AlbumsNavigator.swift
//  FeatureAlbums
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

public enum Route {
    case album(AlbumType)
}

/**
 Inputs declarations here (Presenter)
 */
public protocol AlbumsNavigatorType: class {
    func present(album: AlbumType)
}

public final class AlbumsNavigator: AlbumsNavigatorType {
    private let routerCallback: ((Route) -> Void)

    public init(_ routerCallback: @escaping ((Route) -> Void)) {
        self.routerCallback = routerCallback
    }

    public func present(album: AlbumType) {
        routerCallback(.album(album))
    }

    deinit {
        print("['] \(type(of: self))")
    }
}
