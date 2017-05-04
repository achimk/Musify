//
//  EventHandlerTests.swift
//  MusUI
//
//  Created by Joachim Kret on 04/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import MusUI

final class EventHandlerTests: XCTestCase {
    enum Event: String {
        case success
        case failure
    }

    func testDefaultEventHandler() {
        let handler = EventHandler<Event>()
        let result = handler.handle(.success)
        expect(result)
            .to(beFalse())
    }

    func testEventCallbackHandlerSuccess() {
        let handler = EventCallbackHandler<Event> { event in
            switch event {
            case .success: return true
            case .failure: return false
            }
        }

        let result = handler.handle(.success)
        expect(result)
            .to(beTrue())
    }

    func testEventCallbackHandlerFailure() {
        let handler = EventCallbackHandler<Event> { event in
            switch event {
            case .success: return true
            case .failure: return false
            }
        }

        let result = handler.handle(.failure)
        expect(result)
            .to(beFalse())
    }
}
