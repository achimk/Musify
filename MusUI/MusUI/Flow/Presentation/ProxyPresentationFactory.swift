//
//  ProxyPresentationFactory.swift
//  MusUI
//
//  Created by Joachim Kret on 27/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

public struct ProxyPresentationFactory: PresentationProducable {
    fileprivate let presenter: ViewControllerPresentable

    public init(presenter: ViewControllerPresentable) {
        self.presenter = presenter
    }

    public func createWindowPresenter() -> ViewControllerPresentable {
        return presenter
    }

    public func createNavigationPresenter(animated: Bool) -> ViewControllerPresentable {
        return presenter
    }
}
