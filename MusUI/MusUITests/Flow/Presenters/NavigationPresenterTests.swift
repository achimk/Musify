//
//  NavigationPresenterTests.swift
//  MusUI
//
//  Created by Joachim Kret on 22/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import MusUI

final class NavigationPresenterTests: XCTestCase {

    func testPresentController() {
        let navigationController = UINavigationController()
        let viewController = UIViewController()
        let presenter = NavigationPresenter(
            navigationController: navigationController,
            animated: false
        )

        expect(navigationController.topViewController)
            .to(beNil())

        presenter.present(viewController: viewController)

        expect(navigationController.topViewController)
            .toNot(beNil())

    }
}
