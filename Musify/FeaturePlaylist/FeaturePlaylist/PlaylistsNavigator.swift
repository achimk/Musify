//
//  PlaylistsNavigator.swift
//  FeaturePlaylist
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

/**
 Inputs declarations here (Presenter)
 */
protocol PlaylistsNavigatorType: class {

}

final class PlaylistsNavigator: PlaylistsNavigatorType {

    init() { }

    deinit {
        print("['] \(type(of: self))")
    }
}
