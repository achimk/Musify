//
//  EventsBuilder.swift
//  Musify
//
//  Created by Joachim Kret on 03/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct EventsHandlerBuilder: Collection {
    private var handlers: Array<AlbumsHandler> = []

    init() { }

    mutating func create(input: @escaping ((Albums.Event.Input) -> Bool)) {
        handlers.append(AlbumsHandler(input: input))
    }

    mutating func create(output: @escaping ((Albums.Event.Output) -> Bool)) {
        handlers.append(AlbumsHandler(output: output))
    }

    public var startIndex: Int {
        return handlers.startIndex
    }

    public var endIndex: Int {
        return handlers.endIndex
    }

    public subscript(position: Int) -> AlbumsHandler {
        return handlers[position]
    }

    public func index(after i: Int) -> Int {
        return handlers.index(after: i)
    }
}
