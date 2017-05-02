//
//  NavigatorTests.swift
//  MusUI
//
//  Created by Joachim Kret on 23/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import MusUI

// MARK: NavigatorTests

final class NavigatorTests: XCTestCase {

    // MARK: Tests

    func testScheme() {
        let navigator = createNavigator() as! Navigator
        expect(navigator.scheme)
            .to(equal("router://"))
    }

    func testRoutes() {
        let navigator = createNavigator() as! Navigator
        expect(navigator.routes.isEmpty)
            .to(beFalse())
        expect(navigator.routes.count)
            .to(equal(8))
    }

    func testParseArguments() {
        let navigator = createNavigator()
        let url = URL(string: "router://profile:testUser")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("profile:{user}"))
        expect(location.arguments["user"])
            .to(equal("testUser"))
    }

    func testParsePayload() {
        let navigator = createNavigator()
        let url = URL(string: "router://profile:testUser")!

        typealias Payload = (firstName: String, lastName: String)
        let input = Payload(firstName: "foo", lastName: "bar")

        guard let location = navigator.parse(url: url, payload: input) else {
            fail("Router parsing failed")
            return
        }

        let output = location.payload as? Payload

        expect(location.path)
            .to(equal("profile:{user}"))
        expect(location.arguments["user"])
            .to(equal("testUser"))
        expect(output?.firstName)
            .to(equal("foo"))
        expect(output?.lastName)
            .to(equal("bar"))
    }

    func testParseRouteConcreateMatchCount() {
        let navigator = createNavigator()
        let url = URL(string: "router://profile:admin")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("profile:admin"))
        expect(location.arguments.isEmpty)
            .to(beTrue())
    }

    func testParseRouteWildcardMatchCount() {
        let navigator = createNavigator()
        let url = URL(string: "router://profile:jack")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("profile:{user}"))
        expect(location.arguments["user"])
            .to(equal("jack"))
    }

    func testParseRouteSamePrefix() {
        let navigator = createNavigator()
        let url = URL(string: "router://user:list")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("user:list"))
        expect(location.arguments.isEmpty)
            .to(beTrue())
    }

    func testParseMultipleArguments() {
        let navigator = createNavigator()
        let url = URL(string: "router://user:list:1:admin")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("user:list:{userId}:{kind}"))
        expect(location.arguments["userId"])
            .to(equal("1"))
        expect(location.arguments["kind"])
            .to(equal("admin"))
    }

    func testParseMultipleArgumentsWithFirstWildcard() {
        let navigator = createNavigator()
        let url = URL(string: "router://12:user:list:1:admin")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("{appId}:user:list:{userId}:{kind}"))
        expect(location.arguments["appId"])
            .to(equal("12"))
        expect(location.arguments["userId"])
            .to(equal("1"))
        expect(location.arguments["kind"])
            .to(equal("admin"))
    }

    func testParseWithoutArguments() {
        let navigator = createNavigator()
        let url = URL(string: "router://login")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("login"))
        expect(location.arguments.isEmpty)
            .to(beTrue())
    }

    func testParseWithInvalidScheme() {
        let navigator = createNavigator()
        let url = URL(string: "invalidScheme://login")!

        let location = navigator.parse(url: url)

        expect(location)
            .to(beNil())
    }

    func testParseRegularURLWithFragmentsAndInvalidScheme() {
        let navigator = createNavigator()
        let url = URL(string: "invalidScheme://callback/#access_token=ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ&token_type=Bearer&expires_in=3600")!

        let location = navigator.parse(url: url)

        expect(location)
            .to(beNil())
    }

    func testParseRegularURLWithFragments() {
        let navigator = createNavigator()
        let url = URL(string: "router://callback/#access_token=IjvcgrkQk1p7TyJxKa26rzM1wBMFZW6XoHK4t5Gkt1xQLTN8l7ppR0H3EZXpoP0uLAN49oCDqTHsvnEV&token_type=Bearer&expires_in=3600")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("callback"))
        expect(location.arguments.count)
            .to(equal(3))
        expect(location.arguments["access_token"])
            .to(equal("IjvcgrkQk1p7TyJxKa26rzM1wBMFZW6XoHK4t5Gkt1xQLTN8l7ppR0H3EZXpoP0uLAN49oCDqTHsvnEV"))
        expect(location.arguments["expires_in"])
            .to(equal("3600"))
        expect(location.arguments["token_type"])
            .to(equal("Bearer"))
    }

    func testParseRegularURLWithFragmentsAndGoogleOAuth2AccessToken() {
        let navigator = createNavigator()
        let url = URL(string: "router://callback/#access_token=ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ&token_type=Bearer&expires_in=3600")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("callback"))
        expect(location.arguments.count)
            .to(equal(3))
        expect(location.arguments["access_token"])
            .to(equal("ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ"))
        expect(location.arguments["expires_in"])
            .to(equal("3600"))
        expect(location.arguments["token_type"])
            .to(equal("Bearer"))
    }

    func testParseRegularURLWithFragmentsAndAlternativeAccessToken() {
        let navigator = createNavigator()
        let url = URL(string: "router://callback/#access_token=ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ=&token_type=Bearer&expires_in=3600")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("callback"))
        expect(location.arguments.count)
            .to(equal(3))
        expect(location.arguments["access_token"])
            .to(equal("ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ="))
        expect(location.arguments["expires_in"])
            .to(equal("3600"))
        expect(location.arguments["token_type"])
            .to(equal("Bearer"))
    }

    func testParseRegularURLWithSlashQuery() {
        let navigator = createNavigator()
        let url = URL(string: "router://callback/?access_token=Yo0OMrVZbRWNmgA6BT99hyuTUTNRGvqEEAQyeN1eslclzhFD0M8AidB4Z7Vs2NU8WoSNW0vYb961O38l&token_type=Bearer&expires_in=3600")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("callback"))
        expect(location.arguments.count)
            .to(equal(3))
        expect(location.arguments["access_token"])
            .to(equal("Yo0OMrVZbRWNmgA6BT99hyuTUTNRGvqEEAQyeN1eslclzhFD0M8AidB4Z7Vs2NU8WoSNW0vYb961O38l"))
        expect(location.arguments["expires_in"])
            .to(equal("3600"))
        expect(location.arguments["token_type"])
            .to(equal("Bearer"))
    }

    func testParseRegularURLWithSlashQueryAndGoogleOAuth2AccessToken() {
        let navigator = createNavigator()
        let url = URL(string: "router://callback/?access_token=ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ&token_type=Bearer&expires_in=3600")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("callback"))
        expect(location.arguments.count)
            .to(equal(3))
        expect(location.arguments["access_token"])
            .to(equal("ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ"))
        expect(location.arguments["expires_in"])
            .to(equal("3600"))
        expect(location.arguments["token_type"])
            .to(equal("Bearer"))
    }

    func testParseRegularURLWithSlashQueryAndAlternativeAccessToken() {
        let navigator = createNavigator()
        let url = URL(string: "router://callback/?access_token=ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ=&token_type=Bearer&expires_in=3600")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("callback"))
        expect(location.arguments.count)
            .to(equal(3))
        expect(location.arguments["access_token"])
            .to(equal("ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ="))
        expect(location.arguments["expires_in"])
            .to(equal("3600"))
        expect(location.arguments["token_type"])
            .to(equal("Bearer"))
    }

    func testParseRegularURLWithQuery() {
        let navigator = createNavigator()
        let url = URL(string: "router://callback?access_token=Yo0OMrVZbRWNmgA6BT99hyuTUTNRGvqEEAQyeN1eslclzhFD0M8AidB4Z7Vs2NU8WoSNW0vYb961O38l&token_type=Bearer&expires_in=3600")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("callback"))
        expect(location.arguments.count)
            .to(equal(3))
        expect(location.arguments["access_token"])
            .to(equal("Yo0OMrVZbRWNmgA6BT99hyuTUTNRGvqEEAQyeN1eslclzhFD0M8AidB4Z7Vs2NU8WoSNW0vYb961O38l"))
        expect(location.arguments["expires_in"])
            .to(equal("3600"))
        expect(location.arguments["token_type"])
            .to(equal("Bearer"))
    }

    func testParseRegularURLWithQueryAndGoogleOAuth2AccessToken() {
        let navigator = createNavigator()
        let url = URL(string: "router://callback?access_token=ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ&token_type=Bearer&expires_in=3600")!

        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("callback"))
        expect(location.arguments.count)
            .to(equal(3))
        expect(location.arguments["access_token"])
            .to(equal("ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ"))
        expect(location.arguments["expires_in"])
            .to(equal("3600"))
        expect(location.arguments["token_type"])
            .to(equal("Bearer"))
    }

    func testParseRegularURLWithQueryAndAlternativeAccessToken() {
        let navigator = createNavigator()
        let url = URL(string: "router://callback?access_token=ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ=&token_type=Bearer&expires_in=3600")!
        
        guard let location = navigator.parse(url: url, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.path)
            .to(equal("callback"))
        expect(location.arguments.count)
            .to(equal(3))
        expect(location.arguments["access_token"])
            .to(equal("ya29.Ci8nA1pNVMFffHkS5-sXooNGvTB9q8QPtoM56sWpipRyjhwwEiKyZxvRQTR8saqWzQ="))
        expect(location.arguments["expires_in"])
            .to(equal("3600"))
        expect(location.arguments["token_type"])
            .to(equal("Bearer"))
    }

    func testEncodedURN() {
        let navigator = createNavigator()
        let urn = "organization:hyper oslo:simply awesome"
        let url = navigator.url(from: urn)

        expect(url)
            .toNot(beNil())
        
        guard let location = navigator.parse(url: url!, payload: nil) else {
            fail("Router parsing failed")
            return
        }

        expect(location.arguments["name"])
            .to(equal("hyper oslo"))
        expect(location.arguments["type"])
            .to(equal("simply awesome"))
    }

    // MARK: Private

    private func createNavigator() -> NavigatorType {
        var navigator = Navigator(scheme: "router")
        navigator.routes = [
            "profile:{user}",
            "profile:admin",
            "login",
            "callback",
            "organization:{name}:{type}",
            "user:list:{userId}:{kind}",
            "user:list",
            "{appId}:user:list:{userId}:{kind}"
        ]

        return navigator
    }
}
