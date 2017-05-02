//
//  PlaylistsViewModel.swift
//  Musify
//
//  Created by Joachim Kret on 01/05/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MusServices

protocol PlaylistsInputs {
    func add(playlist: PlaylistType)
    func remove(playlist: PlaylistType)
}

protocol PlaylistsOutputs {
    var onPlaylists: Driver<Array<PlaylistPresentable>> { get }
}

protocol PlaylistsViewModelType {
    var inputs: PlaylistsInputs { get }
    var outputs: PlaylistsOutputs { get }
}

struct PlaylistsViewModel: PlaylistsViewModelType {
    fileprivate let driverPlaylists: Driver<Array<PlaylistPresentable>>
    fileprivate let inputRefresh = PublishSubject<Void>()
    fileprivate let inputAdd = PublishSubject<PlaylistType>()
    fileprivate let inputRemove = PublishSubject<PlaylistType>()

    var inputs: PlaylistsInputs { return self }
    var outputs: PlaylistsOutputs { return self }

    init(service: PlaylistServiceType) {
        let add = inputAdd
            .asObservable()
            .flatMap { (playlist) -> Observable<Bool> in
                return service.add(playlist: playlist)
            }.filter { $0 }

        let remove = inputRemove
            .asObservable()
            .flatMap { (playlist) -> Observable<Bool> in
                return service.remove(playlist: playlist)
            }.filter { $0 }

        let refresh: Observable<Void> = Observable.of(
                Observable.just(true),
                Observable.of(add, remove).merge()
            )
            .concat()
            .filter { $0 }
            .map { _ in return }

        self.driverPlaylists = refresh.flatMapLatest { Void -> Observable<Array<PlaylistPresentable>> in
            return service.playlists()
                .mapResult()
                .map { $0.recover([]) }
                .map { $0.map { PlaylistPresentationItem(playlist: $0) as PlaylistPresentable } }
        }.asDriver(onErrorDriveWith: Driver.never())
    }
}

extension PlaylistsViewModel: PlaylistsInputs {
    func add(playlist: PlaylistType) {
        inputAdd.onNext(playlist)
    }

    func remove(playlist: PlaylistType) {
        inputRemove.onNext(playlist)
    }
}

extension PlaylistsViewModel: PlaylistsOutputs {
    var onPlaylists: Driver<Array<PlaylistPresentable>> { return driverPlaylists }
}
