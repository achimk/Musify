//
//  AlbumsViewModel.swift
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

protocol AlbumsInputs {

}

protocol AlbumsOutputs {
    var onAlbums: Driver<Array<AlbumPresentable>> { get }
}

protocol AlbumsViewModelType {
    var inputs: AlbumsInputs { get }
    var outputs: AlbumsOutputs { get }
}

struct AlbumsViewModel: AlbumsViewModelType {
    fileprivate let driverAlbums: Driver<Array<AlbumPresentable>>

    var inputs: AlbumsInputs { return self }
    var outputs: AlbumsOutputs { return self }

    init(service: AlbumsServiceType, artist: ArtistType) {
        self.driverAlbums = service.albums(fromArtist: artist)
            .mapResult()
            .map { $0.recover([]) }
            .map { $0.map { AlbumPresentationItem(album: $0) as AlbumPresentable } }
            .asDriver(onErrorDriveWith: Driver.never())
    }
}

extension AlbumsViewModel: AlbumsInputs {

}

extension AlbumsViewModel: AlbumsOutputs {
    var onAlbums: Driver<Array<AlbumPresentable>> { return driverAlbums }
}
