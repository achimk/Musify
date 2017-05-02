//
//  PresentationFactoryTests.swift
//  MusUI
//
//  Created by Joachim Kret on 22/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import MusUI

final class PresentationFactoryTests: XCTestCase {

    /*
    func testCreateWindowPresenter() {
        let context = createContext()
        let factory = PresentationFactory(context: context)

        let presenter = factory.createWindowPresenter()

        expect(presenter)
            .toNot(beNil())
        expect(context.window.rootViewController)
            .to(beNil())

        let viewController = UIViewController()
        presenter.present(viewController: viewController)

        expect(context.window.rootViewController)
            .toNot(beNil())
    }

    func testCreateNavigationPresenter() {
        let context = createContext()
        let factory = PresentationFactory(context: context)

        let presenter = factory.createNavigationPresenter()

        expect(presenter)
            .toNot(beNil())
        expect(context.navigationController.topViewController)
            .to(beNil())

        let viewController = UIViewController()
        presenter.present(viewController: viewController)

        expect(context.navigationController.topViewController)
            .toNot(beNil())
    }

    func testCreateModalPresenter() {
        let context = createContext()
        let factory = PresentationFactory(context: context)

        let viewController = UIViewController()
        let presenter = factory.createModalPresenter(from: viewController, animated: false)

        expect(presenter)
            .toNot(beNil())
    }

    private func createContext() -> PresentationContext {
        let window = UIWindow()
        let navigationController = UINavigationController()
        return PresentationContext(
            window: window,
            navigationController: navigationController
        )
    }
 */
}
