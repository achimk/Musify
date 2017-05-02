//
//  PlaylistType.swift
//  MusServices
//
//  Created by Joachim Kret on 01/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

public protocol PlaylistType {
    var name: String { get }
}

public protocol PlaylistConvertible {
    func asPlaylist() -> PlaylistType
}

extension PlaylistConvertible where Self: PlaylistType {
    public final func asPlaylist() -> PlaylistType {
        return self
    }
}

extension PlaylistType where Self: Equatable { }
public func ==(lhs: PlaylistType, rhs: PlaylistType) -> Bool {
    return lhs.name == rhs.name
}



public struct Playlist: PlaylistType {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}
