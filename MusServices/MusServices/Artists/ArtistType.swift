//
//  ArtistType.swift
//  MusServices
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

public protocol ArtistType {
    var name: String { get }
}

public protocol ArtistConvertible {
    func asArtist() -> ArtistType
}

extension ArtistConvertible where Self: ArtistType {
    final func asArtist() -> ArtistType {
        return self
    }
}

public struct Artist: ArtistType {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}
