//
//  NavigationPresenter.swift
//  MusUI
//
//  Created by Joachim Kret on 22/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

public struct NavigationPresenter: ViewControllerPresentable {
    public let navigationController: UINavigationController
    public let animated: Bool

    public init(navigationController: UINavigationController, animated: Bool) {
        self.navigationController = navigationController
        self.animated = animated
    }

    public func present(viewController: UIViewController) {
        let shouldAnimate = navigationController.viewControllers.count > 0 && animated
        navigationController.pushViewController(viewController, animated: shouldAnimate)
    }
}
