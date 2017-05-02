//
//  CustomCallbackPresenter.swift
//  MusUI
//
//  Created by Joachim Kret on 22/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

public struct CustomCallbackPresenter: ViewControllerPresentable {
    public let callback: ((UIViewController) -> Void)

    public init(callback: @escaping ((UIViewController) -> Void)) {
        self.callback = callback
    }

    public func present(viewController: UIViewController) {
        callback(viewController)
    }
}
