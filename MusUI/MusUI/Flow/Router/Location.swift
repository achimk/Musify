//
//  Location.swift
//  MusUI
//
//  Created by Joachim Kret on 23/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

// MARK: LocationType

public protocol LocationType {
    var scheme: String { get }
    var path: String { get }
    var arguments: Dictionary<String, String> { get }
    var payload: Optional<Any> { get }
}

// MARK: Location

public struct Location: LocationType {
    public let scheme: String
    public let path: String
    public let arguments: Dictionary<String, String>
    public let payload: Optional<Any>

    // MARK: Init

    public init(
        scheme: String,
        path: String,
        arguments: Dictionary<String, String> = [:],
        payload: Optional<Any> = nil) {

        self.scheme = scheme
        self.path = path
        self.arguments = arguments
        self.payload = payload
    }
}
