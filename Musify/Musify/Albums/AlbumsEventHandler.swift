//
//  AlbumsEventHandler.swift
//  Musify
//
//  Created by Joachim Kret on 03/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

struct Albums {
    struct Event {
        enum Input {
            case fetch
            case select(album: AlbumType)
        }

        enum Output {
            case fetched(albums: Array<AlbumPresentable>)
        }
    }
}

protocol AlbumsEventHandling {
    func handle(input: Albums.Event.Input) -> Bool
    func handle(output: Albums.Event.Output) -> Bool
}

extension AlbumsEventHandling {
    func handle(input: Albums.Event.Input) -> Bool { return false }
    func handle(output: Albums.Event.Output) -> Bool { return false }
}

protocol AlbumsEventTraveling {
    var next: AlbumsEventHandling? { get }
}

protocol AlbumsEventListening {
    func on(input: Albums.Event.Input)
    func on(output: Albums.Event.Output)
}

extension AlbumsEventListening {
    func on(input: Albums.Event.Input) { }
    func on(output: Albums.Event.Output) { }
}

struct AlbumsPlugin: AlbumsEventListening {
    private let onInput: ((Albums.Event.Input) -> Void)
    private let onOutput: ((Albums.Event.Output) -> Void)

    init(input: @escaping ((Albums.Event.Input) -> Void) = { _ in return },
         output: @escaping ((Albums.Event.Output) -> Void) = { _ in return }) {

        self.onInput = input
        self.onOutput = output
    }

    func on(input: Albums.Event.Input) { onInput(input) }
    func on(output: Albums.Event.Output) { onOutput(output) }
}

struct AlbumsHandler: AlbumsEventHandling {
    private let onInput: ((Albums.Event.Input) -> Bool)
    private let onOutput: ((Albums.Event.Output) -> Bool)

    init(input: @escaping ((Albums.Event.Input) -> Bool) = { _ in false },
         output: @escaping ((Albums.Event.Output) -> Bool) = { _ in false }) {

        self.onInput = input
        self.onOutput = output
    }

    func handle(input: Albums.Event.Input) -> Bool { return onInput(input) }
    func handle(output: Albums.Event.Output) -> Bool { return onOutput(output) }
}

final class AlbumsEventsCenter: AlbumsEventHandling {
    var plugins: Array<AlbumsEventListening> = []
    var handlers = EventsHandlerBuilder()

    init() {

    }

    func handle(input: Albums.Event.Input) -> Bool {
        for plugin in plugins {
            plugin.on(input: input)
        }

        for handler in handlers {
            if handler.handle(input: input) {
                return true
            }
        }

        return false
    }

    func handle(output: Albums.Event.Output) -> Bool {
        for plugin in plugins {
            plugin.on(output: output)
        }

        for handler in handlers {
            if handler.handle(output: output) {
                return true
            }
        }

        return false
    }
}
