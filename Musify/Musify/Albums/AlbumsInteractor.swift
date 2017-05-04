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
import MusUI
import MusServices

final class AlbumsInteractor: EventHandling {
    private let inputRequest = PublishSubject<Void>()
    private let disposeBag = DisposeBag()

    init(service: AlbumsServiceType, artist: ArtistType, listener: EventListener<AlbumsEvent.Output>) {
        self.inputRequest
            .asObservable()
            .flatMap {
                return service.albums(fromArtist: artist)
                    .mapResult()
                    .map { $0.recover([]) }
                    .map { $0.map { AlbumPresentationItem(album: $0) as AlbumPresentable } }
            }
            .asDriver(onErrorDriveWith: Driver.never())
            .drive(onNext: { (albums) in
                listener.on(.present(albums: albums))
            }).addDisposableTo(disposeBag)
    }

    deinit {
        print("['] Interactor deinit")
    }

    func handle(_ event: AlbumsEvent.Input) -> Bool {
        switch event {
        case .request:
            inputRequest.onNext()
            return true

        default:
            return false
        }
    }
}
