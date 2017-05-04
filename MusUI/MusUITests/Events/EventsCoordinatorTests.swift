//
//  EventsCoordinatorTests.swift
//  MusUI
//
//  Created by Joachim Kret on 04/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import MusUI

final class EventsCoordinatorTests: XCTestCase {
    enum Event: String {
        case success
        case failure
    }

    struct StructHandler: EventHandling, EventListening {
        typealias Callback = ((Event) -> Void)
        private let callback: Callback?

        init(_ callback: Callback? = nil) {
            self.callback = callback
        }

        func handle(_ event: Event) -> Bool {
            switch event {
            case .success:
                on(event)
                return true
            case .failure:
                return false
            }
        }

        func on(_ event: Event) {
            callback?(event)
        }
    }

    final class ObjectHandler: EventHandling, EventListening {
        typealias Callback = ((Event) -> Void)
        private let callback: Callback?

        init(_ callback: Callback? = nil) {
            self.callback = callback
        }

        func handle(_ event: Event) -> Bool {
            switch event {
            case .success:
                on(event)
                return true
            case .failure:
                return false
            }
        }

        func on(_ event: Event) {
            callback?(event)
        }
    }

    func testCreateWithName() {
        let coordinator = EventsCoordinator<Event>("CustomName")
        expect(coordinator.name)
            .to(equal("CustomName"))
        expect(coordinator.handlers.count)
            .to(equal(0))
        expect(coordinator.preListeners.count)
            .to(equal(0))
        expect(coordinator.postListeners.count)
            .to(equal(0))
    }

    func testCreateWithoutName() {
        let coordinator = EventsCoordinator<Event>()
        expect(coordinator.name)
            .to(beNil())
        expect(coordinator.handlers.count)
            .to(equal(0))
        expect(coordinator.preListeners.count)
            .to(equal(0))
        expect(coordinator.postListeners.count)
            .to(equal(0))
    }

    func testCreateHandlerFromCallback() {
        let coordinator = EventsCoordinator<Event>()
        expect(coordinator.handlers.count)
            .to(equal(0))

        coordinator.handle { (event) -> Bool in
            switch event {
            case .success: return true
            case .failure: return false
            }
        }

        expect(coordinator.handlers.count)
            .to(equal(1))

        var result = coordinator.handle(.failure)
        expect(result)
            .to(beFalse())

        result = coordinator.handle(.success)
        expect(result)
            .to(beTrue())
    }

    func testAppendHandler() {
        let coordinator = EventsCoordinator<Event>()
        expect(coordinator.handlers.count)
            .to(equal(0))

        let handler = EventCallbackHandler<Event> { event in
            switch event {
            case .success: return true
            case .failure: return false
            }
        }
        coordinator.append(handler: handler)

        expect(coordinator.handlers.count)
            .to(equal(1))

        var result = coordinator.handle(.failure)
        expect(result)
            .to(beFalse())

        result = coordinator.handle(.success)
        expect(result)
            .to(beTrue())
    }

    func testAppendHandling() {
        let coordinator = EventsCoordinator<Event>()
        expect(coordinator.handlers.count)
            .to(equal(0))

        let handler = StructHandler()
        coordinator.append(handler: handler)

        expect(coordinator.handlers.count)
            .to(equal(1))

        var result = coordinator.handle(.failure)
        expect(result)
            .to(beFalse())

        result = coordinator.handle(.success)
        expect(result)
            .to(beTrue())
    }

    func testAppendHandlingObject() {
        let coordinator = EventsCoordinator<Event>()
        expect(coordinator.handlers.count)
            .to(equal(0))

        let handler = ObjectHandler()
        coordinator.append(handler: handler)

        expect(coordinator.handlers.count)
            .to(equal(1))

        var result = coordinator.handle(.failure)
        expect(result)
            .to(beFalse())

        result = coordinator.handle(.success)
        expect(result)
            .to(beTrue())
    }

    func testAppendMultipleHandlers() {
        let coordinator = EventsCoordinator<Event>()
        expect(coordinator.handlers.count)
            .to(equal(0))

        let success = EventCallbackHandler<Event> { event in
            switch event {
            case .success: return true
            case .failure: return false
            }
        }
        coordinator.append(handler: success)
        expect(coordinator.handlers.count)
            .to(equal(1))

        let failure = EventCallbackHandler<Event> { event in
            switch event {
            case .success: return false
            case .failure: return true
            }
        }
        coordinator.append(handler: failure)
        expect(coordinator.handlers.count)
            .to(equal(2))

        var result = coordinator.handle(.failure)
        expect(result)
            .to(beTrue())

        result = coordinator.handle(.success)
        expect(result)
            .to(beTrue())
    }

    func testCreateListenerFromCallback() {
        var currentEvent: Event?
        let coordinator = EventsCoordinator<Event>()

        coordinator.listen { (event) in
            currentEvent = event
        }
        coordinator.on(.failure)
        expect(currentEvent)
            .to(equal(Event.failure))

        coordinator.on(.success)
        expect(currentEvent)
            .to(equal(Event.success))
    }

    func testAppendListener() {
        var currentEvent: Event?
        let coordinator = EventsCoordinator<Event>()

        let listener = EventCallbackListener<Event> { event in
            currentEvent = event
        }
        coordinator.append(listener: listener)
        coordinator.on(.failure)
        expect(currentEvent)
            .to(equal(Event.failure))

        coordinator.on(.success)
        expect(currentEvent)
            .to(equal(Event.success))
    }

    func testAppendListening() {
        var currentEvent: Event?
        let coordinator = EventsCoordinator<Event>()

        let listener = StructHandler() { event in
            currentEvent = event
        }
        coordinator.append(listener: listener)
        expect(coordinator.preListeners.count)
            .to(equal(1))

        coordinator.on(.failure)
        expect(currentEvent)
            .to(equal(Event.failure))

        coordinator.on(.success)
        expect(currentEvent)
            .to(equal(Event.success))
    }

    func testAppendListeningObject() {
        var currentEvent: Event?
        let coordinator = EventsCoordinator<Event>()

        let listener = ObjectHandler() { event in
            currentEvent = event
        }
        coordinator.append(listener: listener)
        expect(coordinator.preListeners.count)
            .to(equal(1))

        coordinator.on(.failure)
        expect(currentEvent)
            .to(equal(Event.failure))

        coordinator.on(.success)
        expect(currentEvent)
            .to(equal(Event.success))
    }

    func testAppendMultipleListeners() {
        var eventBefore: Event?
        var eventAfter: Event?

        let coordinator = EventsCoordinator<Event>()

        coordinator.listen(policy: .before) { event in
            eventBefore = event
        }
        expect(coordinator.preListeners.count)
            .to(equal(1))

        coordinator.listen(policy: .after) { event in
            eventAfter = event
        }
        expect(coordinator.postListeners.count)
            .to(equal(1))

        coordinator.on(.success)
        expect(eventBefore)
            .to(equal(Event.success))
        expect(eventAfter)
            .to(equal(Event.success))
    }

    func testListenersOrder() {
        var eventBefore: Event?
        var eventHandle: Event?
        var eventAfter: Event?

        let coordinator = EventsCoordinator<Event>()

        coordinator.listen(policy: .before) { event in
            eventBefore = event

            expect(eventHandle)
                .to(beNil())
            expect(eventAfter)
                .to(beNil())
        }

        coordinator.listen(policy: .after) { event in
            eventAfter = event

            expect(eventBefore)
                .to(equal(event))
            expect(eventHandle)
                .to(equal(event))
        }

        coordinator.handle { event -> Bool in
            eventHandle = event

            expect(eventBefore)
                .to(equal(event))
            expect(eventAfter)
                .to(beNil())

            return true
        }

        let result = coordinator.handle(.success)
        expect(result)
            .to(beTrue())
        expect(eventBefore)
            .to(equal(Event.success))
        expect(eventAfter)
            .to(equal(Event.success))
        expect(eventHandle)
            .to(equal(Event.success))
    }
}
