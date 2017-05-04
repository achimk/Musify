//
//  EventsCoordinatorCenterTests.swift
//  MusUI
//
//  Created by Joachim Kret on 04/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import MusUI

final class EventsCoordinatorCenterTests: XCTestCase {
    enum Input: String {
        case fetch
    }
    enum Output: String {
        case success
        case failure
    }

    func testDefaultCreate() {
        let center = EventsCoordinatorCenter<Input, Output>()

        expect(center)
            .toNot(beNil())
        expect(center.inputs)
            .toNot(beNil())
        expect(center.outputs)
            .toNot(beNil())

        expect(center.inputs.name)
            .to(beNil())
        expect(center.inputs.handlers.count)
            .to(equal(0))
        expect(center.inputs.preListeners.count)
            .to(equal(0))
        expect(center.inputs.postListeners.count)
            .to(equal(0))

        expect(center.outputs.name)
            .to(beNil())
        expect(center.outputs.handlers.count)
            .to(equal(0))
        expect(center.outputs.preListeners.count)
            .to(equal(0))
        expect(center.outputs.postListeners.count)
            .to(equal(0))
    }
}
