//
//  EventListenerTests.swift
//  MusUI
//
//  Created by Joachim Kret on 04/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import MusUI

final class EventListenerTests: XCTestCase {
    enum Event: String {
        case success
        case failure
    }

    func testDefaultEventListener() {
        let listener = EventListener<Event>()
        let result = listener.handle(.success)
        expect(result)
            .to(beFalse())
    }

    func testEventCallbackListener() {
        var currentEvent: Event?
        let listener = EventCallbackListener<Event> { event in
            currentEvent = event
        }

        listener.on(.failure)
        expect(currentEvent)
            .to(equal(Event.failure))

        listener.on(.success)
        expect(currentEvent)
            .to(equal(Event.success))
    }

    func testEventCallbackListenerHandle() {
        var currentEvent: Event?
        let listener = EventCallbackListener<Event> { event in
            currentEvent = event
        }

        var result = listener.handle(.failure)
        expect(currentEvent)
            .to(equal(Event.failure))
        expect(result)
            .to(beFalse())

        result = listener.handle(.success)
        expect(currentEvent)
            .to(equal(Event.success))
        expect(result)
            .to(beFalse())
    }
}
