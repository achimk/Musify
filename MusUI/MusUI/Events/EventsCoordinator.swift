//
//  EventsCoordinator.swift
//  MusUI
//
//  Created by Joachim Kret on 04/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

public enum ListenerDispatchPolicy {
    case before
    case after
}

public final class EventsCoordinator<E>: EventListener<E>, CustomStringConvertible {
    internal let name: String?
    internal var handlers: Array<EventHandler<Event>> = []
    internal var preListeners: Array<EventListener<Event>> = []
    internal var postListeners: Array<EventListener<Event>> = []

    public var description: String {
        guard let name = name else { return "\(type(of: self))" }
        return "\(type(of: self)) (\(name))"

    }

    public init(_ name: String? = nil) {
        self.name = name
    }

    public func handle(_ handler: @escaping ((Event) -> Bool)) {
        handlers.append(EventCallbackHandler(handler).asHandler())
    }

    public func append(handler: EventHandler<Event>) {
        handlers.append(handler)
    }

    public func append<T: EventHandling>(handler: T) where T.Event == Event {
        handlers.append(handler.asHandler())
    }

    public func append<T: EventHandling & AnyObject>(handler: T) where T.Event == Event {
        handlers.append(handler.asHandler())
    }

    public func listen(
        policy: ListenerDispatchPolicy = .before,
        listener: @escaping ((Event) -> Void)) {

        append(listener: EventCallbackListener(listener).asListener(), using: policy)
    }

    public func append(
        listener: EventListener<Event>,
        policy: ListenerDispatchPolicy = .before) {

        append(listener: listener, using: policy)
    }

    public func append<T: EventListening>(
        listener: T,
        policy: ListenerDispatchPolicy = .before
        ) where T.Event == Event {

        append(listener: listener.asListener(), using: policy)
    }

    public func append<T: EventListening & AnyObject>(
        listener: T,
        policy: ListenerDispatchPolicy = .before
        ) where T.Event == Event {

        append(listener: listener.asListener(), using: policy)
    }

    public override func on(_ event: Event) {
        _ = handle(event)
    }

    public override func handle(_ event: Event) -> Bool {
        var value: Bool = false

        preListeners.forEach { (listener) in
            listener.on(event)
        }

        for handler in handlers {
            if handler.handle(event) {
                value = true
                break
            }
        }

        postListeners.forEach { (listener) in
            listener.on(event)
        }
        
        return value
    }

    private func append(listener: EventListener<Event>, using policy: ListenerDispatchPolicy) {
        switch policy {
        case .before:
            preListeners.append(listener)
        case .after:
            postListeners.append(listener)
        }
    }


}
