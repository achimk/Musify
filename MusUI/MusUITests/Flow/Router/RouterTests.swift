//
//  RouterTests.swift
//  MusUI
//
//  Created by Joachim Kret on 23/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import MusUI

// MARK: RouterTests

final class RouterTests: XCTestCase {

    // MARK: Internal Classes

    final class SuccessRoute: Routable {
        var callback: ((Void) -> Void)?
        var resolved: Bool = false

        init(callback: ((Void) -> Void)? = nil) {
            self.callback = callback
        }

        func navigate(to location: LocationType, using presenter: ViewControllerPresentable) throws {
            resolved = true
            callback?()
        }
    }

    final class FailureRoute: Routable {
        var resolved: Bool = false

        enum InternalError: Error {
            case unknown
        }

        func navigate(to location: LocationType, using presenter: ViewControllerPresentable) throws {
            resolved = true
            throw InternalError.unknown
        }
    }

    final class ErrorRouteHandler: ErrorRoutable {
        var error: RouteError?

        func handle(routeError error: RouteError, using presenter: ViewControllerPresentable) {
            self.error = error
        }
    }

    // MARK: Params

    var router: Router!
    var errorHandler: ErrorRouteHandler!
    var successRoute: SuccessRoute!
    var failureRoute: FailureRoute!

    // MARK: Setup

    override func setUp() {
        super.setUp()

        self.router = Router()
        self.errorHandler = ErrorRouteHandler()
        self.successRoute = SuccessRoute()
        self.failureRoute = FailureRoute()

        self.router.errorRouteHandler = self.errorHandler
    }

    // MARK: Tests

    func testNavigateIfRouteRegistered() {
        let location = Location(scheme: "app", path: "test")
        let presenter = CustomCallbackPresenter() { _ in }

        router.routes["test"] = successRoute

        expect(self.successRoute.resolved)
            .to(beFalse())
        expect(self.errorHandler.error)
            .to(beNil())

        router.navigate(to: location, using: presenter)

        expect(self.successRoute.resolved)
            .to(beTrue())
        expect(self.errorHandler.error)
            .to(beNil())
    }

    func testNavigateIfRouteNotRegistered() {
        let location = Location(scheme: "app", path: "test")
        let presenter = CustomCallbackPresenter() { _ in }

        expect(self.successRoute.resolved)
            .to(beFalse())
        expect(self.errorHandler.error)
            .to(beNil())

        router.navigate(to: location, using: presenter)

        expect(self.successRoute.resolved)
            .to(beFalse())
        expect(self.errorHandler.error)
            .toNot(beNil())
    }

    func testNavigateIfRouteThrowsError() {
        let location = Location(scheme: "app", path: "throw")
        let presenter = CustomCallbackPresenter() { _ in }

        router.routes["throw"] = failureRoute

        expect(self.failureRoute.resolved)
            .to(beFalse())
        expect(self.errorHandler.error)
            .to(beNil())

        router.navigate(to: location, using: presenter)

        expect(self.failureRoute.resolved)
            .to(beTrue())
        expect(self.errorHandler.error)
            .toNot(beNil())
    }
}
