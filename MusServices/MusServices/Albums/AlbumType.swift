//
//  AlbumType.swift
//  MusServices
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

public protocol AlbumType {
    var name: String { get }
}

public protocol AlbumConvertible {
    func asAlbum() -> AlbumType
}

extension AlbumConvertible where Self: AlbumType {
    final func asAlbum() -> AlbumType {
        return self
    }
}

public struct Album: AlbumType {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}
