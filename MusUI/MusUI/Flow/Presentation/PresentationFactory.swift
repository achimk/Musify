//
//  PresentationFactory.swift
//  MusUI
//
//  Created by Joachim Kret on 22/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

public struct PresentationFactory: PresentationProducable {
    fileprivate let window: UIWindow
    fileprivate let navigationController: UINavigationController

    public init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()

        createWindowPresenter().present(viewController: navigationController)
        window.makeKeyAndVisible()
    }

    public func createWindowPresenter() -> ViewControllerPresentable {
        return WindowPresenter(window: window)
    }
    
    public func createNavigationPresenter(animated: Bool = true) -> ViewControllerPresentable {
        return NavigationPresenter(navigationController: navigationController, animated: animated)
    }
}
