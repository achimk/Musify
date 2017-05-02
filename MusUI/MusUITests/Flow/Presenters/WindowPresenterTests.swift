//
//  WindowPresenterTests.swift
//  MusUI
//
//  Created by Joachim Kret on 22/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import MusUI

final class WindowPresenterTests: XCTestCase {

    func testPresentController() {
        let window = UIWindow()
        let viewController = UIViewController()
        let presenter = WindowPresenter(window: window)

        expect(window.rootViewController)
            .to(beNil())

        presenter.present(viewController: viewController)

        expect(window.rootViewController)
            .toNot(beNil())
    }
}

