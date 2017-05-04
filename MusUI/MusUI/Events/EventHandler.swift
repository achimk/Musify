//
//  EventHandler.swift
//  MusUI
//
//  Created by Joachim Kret on 04/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

public protocol EventHandling {
    associatedtype Event
    func handle(_ event: Event) -> Bool
}

extension EventHandling {
    public func asHandler() -> EventHandler<Event> {
        let handler = self
        return EventCallbackHandler { event in
            return handler.handle(event)
        }.asHandler()
    }
}

extension EventHandling where Self: AnyObject {
    public func asHandler() -> EventHandler<Event> {
        return EventCallbackHandler { [weak self] event in
            return self?.handle(event) ?? false
        }.asHandler()
    }
}

public class EventHandler<E>: EventHandling {
    public typealias Event = E

    public init() { }

    public func handle(_ event: Event) -> Bool {
        return false
    }

    public final func asHandler() -> EventHandler<Event> {
        return self
    }
}

public final class EventCallbackHandler<E>: EventHandler<E> {
    public typealias Callback = ((Event) -> Bool)
    private let callback: Callback

    public init(_ callback: @escaping Callback) {
        self.callback = callback
    }

    public override func handle(_ event: Event) -> Bool {
        return callback(event)
    }
}
