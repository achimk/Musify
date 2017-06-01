//
//  ListNavigator.swift
//  MusTodo
//
//  Created by Joachim Kret on 01/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

/**
 Inputs declarations here (Presenter)
 */
protocol ListNavigatorType: class {

}

final class ListNavigator: ListNavigatorType {

    init() { }

    deinit {
        print("['] \(type(of: self))")
    }
}
