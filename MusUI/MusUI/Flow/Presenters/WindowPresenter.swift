//
//  WindowPresenter.swift
//  MusUI
//
//  Created by Joachim Kret on 22/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

public struct WindowPresenter: ViewControllerPresentable {
    public let window: UIWindow

    public init(window: UIWindow) {
        self.window = window
    }

    public func present(viewController: UIViewController) {
        window.rootViewController = viewController
    }
}
