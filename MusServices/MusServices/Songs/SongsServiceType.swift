//
//  SongsServiceType.swift
//  MusServices
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

public protocol SongsServiceType {
    func songs(fromAlbum album: AlbumType) -> Observable<Array<SongType>>
}
