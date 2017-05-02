//
//  AlbumsServiceType.swift
//  MusServices
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

public protocol AlbumsServiceType {
    func albums(fromArtist artist: ArtistType) -> Observable<Array<AlbumType>>
}
