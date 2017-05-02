//
//  SongType.swift
//  MusServices
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

public protocol SongType {
    var name: String { get }
    var length: UInt { get }
}

public protocol SongConvertible {
    func asSong() -> SongType
}

extension SongConvertible where Self: SongType {
    public final func asSong() -> SongType {
        return self
    }
}

public struct Song: SongType {
    public let name: String
    public let length: UInt

    public init(name: String, length: UInt) {
        self.name = name
        self.length = length
    }
}
