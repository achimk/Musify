//
//  PlaylistsInteractor.swift
//  FeaturePlaylist
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices
import MusToolkit
import RxSwift
import Result

/**
 Inputs declarations here (Interactor)
 */
protocol PlaylistsInteractorInputs: class {
    func createAndAdd(name: String)
    func add(playlist: PlaylistType)
    func remove(playlist: PlaylistType)
}

/**
 Outputs declarations here (Presenter)
 */
protocol PlaylistsInteractorOutputs: class {
    func playlists(_ result: PlaylistsResult)
}

protocol PlaylistsInteractorType {
    var inputs: PlaylistsInteractorInputs { get }
    var outputs: PlaylistsInteractorOutputs? { get }
}

final class PlaylistsInteractor: PlaylistsInteractorType {
    fileprivate let service: PlaylistServiceType
    fileprivate let inputAdd = PublishSubject<PlaylistType>()
    fileprivate let inputRemove = PublishSubject<PlaylistType>()
    fileprivate let inputRefresh = PublishSubject<Void>()
    fileprivate let dispose = DisposeBag()

    var inputs: PlaylistsInteractorInputs { return self }
    weak var outputs: PlaylistsInteractorOutputs?

    init(outputs: PlaylistsInteractorOutputs,
         service: PlaylistServiceType) {

        self.outputs = outputs
        self.service = service

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

        refresh.flatMapLatest({ Void -> Observable<PlaylistsResult> in
            return service.playlists().mapResult()
        })
        .subscribe(onNext: { [weak self] (result) in
            self?.outputs?.playlists(result)
        })
        .addDisposableTo(dispose)
    }

    deinit {
        print("['] \(type(of: self))")
    }
}

extension PlaylistsInteractor: PlaylistsInteractorInputs {
    func createAndAdd(name: String) {
        let playlist = Playlist(name: name)
        add(playlist: playlist)
    }

    func add(playlist: PlaylistType) {
        inputAdd.onNext(playlist)
    }

    func remove(playlist: PlaylistType) {
        inputRemove.onNext(playlist)
    }
}
