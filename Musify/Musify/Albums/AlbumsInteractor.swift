//
//  AlbumsInteractor.swift
//  Musify
//
//  Created by Joachim Kret on 03/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MusServices

struct AlbumsInteractor {
    private let inputFetch = PublishSubject<Void>()
    private let disposeBag = DisposeBag()

    init(service: AlbumsServiceType, artist: ArtistType, eventHandler: AlbumsEventsCenter) {

        inputFetch
            .asObservable()
            .flatMap {
                return service.albums(fromArtist: artist)
                    .mapResult()
                    .map { $0.recover([]) }
                    .map { $0.map { AlbumPresentationItem(album: $0) as AlbumPresentable } }
            }
            .asDriver(onErrorDriveWith: Driver.never())
            .drive(onNext: { (albums) in
                _ = eventHandler.handle(output: .fetched(albums: albums))
            }).addDisposableTo(disposeBag)

        let interactor = self
        eventHandler.handlers.create(input: { (event) -> Bool in
            switch event {
            case .fetch:
                interactor.inputFetch.onNext()
                return true
            default:
                return false
            }
        })
    }
}
