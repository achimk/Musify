//
//  SongsViewModel.swift
//  Musify
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Result
import RxSwift
import RxCocoa
import MusServices
import MusToolkit

protocol SongsInputs {

}

protocol SongsOutputs {
    var onSongs: Driver<Array<SongPresentable>> { get }
}

protocol SongsViewModelType {
    var inputs: SongsInputs { get }
    var outputs: SongsOutputs { get }
}

struct SongsViewModel: SongsViewModelType {
    fileprivate let driverSongs: Driver<Array<SongPresentable>>

    var inputs: SongsInputs { return self }
    var outputs: SongsOutputs { return self }

    init(service: SongsServiceType, album: AlbumType) {
        self.driverSongs = service.songs(fromAlbum: album)
            .mapResult()
            .map { $0.recover([]) }
            .map { $0.map { SongPresentationItem(song: $0) as SongPresentable } }
            .asDriver(onErrorDriveWith: Driver.never())
    }
}

extension SongsViewModel: SongsInputs {

}

extension SongsViewModel: SongsOutputs {
    var onSongs: Driver<Array<SongPresentable>> { return driverSongs }
}
