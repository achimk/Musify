//
//  EventListener.swift
//  MusUI
//
//  Created by Joachim Kret on 04/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

public protocol EventListening {
    associatedtype Event
    func on(_ event: Event)
}

extension EventListening where Self: Any {
    public func asListener() -> EventListener<Event> {
        let listener = self
        return EventCallbackListener { event in
            listener.on(event)
        }.asListener()
    }
}

extension EventListening where Self: AnyObject {
    public func asListener() -> EventListener<Event> {
        return EventCallbackListener { [weak self] event in
            self?.on(event)
        }.asListener()
    }
}

public class EventListener<E>: EventHandler<E>, EventListening {

    public func on(_ event: Event) { }

    public override func handle(_ event: Event) -> Bool {
        on(event)
        return false
    }

    public final func asListener() -> EventListener<Event> {
        return self
    }
}

public final class EventCallbackListener<E>: EventListener<E> {
    public typealias Callback = ((Event) -> Void)
    private let callback: Callback

    public init(_ callback: @escaping Callback) {
        self.callback = callback
    }

    public override func on(_ event: Event) {
        callback(event)
    }
}
