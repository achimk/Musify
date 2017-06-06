//
//  SongsNavigator.swift
//  FeatureSongs
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

/**
 Inputs declarations here (Presenter)
 */
protocol SongsNavigatorType: class {

}

final class SongsNavigator: SongsNavigatorType {

    init() { }

    deinit {
        print("['] \(type(of: self))")
    }
}
