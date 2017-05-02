//
//  PlaylistServiceType.swift
//  MusServices
//
//  Created by Joachim Kret on 01/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

public protocol PlaylistServiceType {
    func playlists() -> Observable<Array<PlaylistType>>
    func add(playlist: PlaylistType) -> Observable<Bool>
    func remove(playlist: PlaylistType) -> Observable<Bool>
}
