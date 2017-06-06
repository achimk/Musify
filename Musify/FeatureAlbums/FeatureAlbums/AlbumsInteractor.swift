//
//  AlbumsInteractor.swift
//  FeatureAlbums
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices
import MusToolkit
import Result
import RxSwift

/**
 Inputs declarations here (Interactor)
 */
protocol AlbumsInteractorInputs: class {
    func request()
}

/**
 Outputs declarations here (Presenter)
 */
protocol AlbumsInteractorOutputs: class {
    func response(_ result: AlbumsResult)
}

protocol AlbumsInteractorType {
    var inputs: AlbumsInteractorInputs { get }
    var outputs: AlbumsInteractorOutputs? { get }
}

final class AlbumsInteractor: AlbumsInteractorType {
    fileprivate let artist: ArtistType
    fileprivate let service: AlbumsServiceType
    fileprivate var dispose = DisposeBag()

    var inputs: AlbumsInteractorInputs { return self }
    weak var outputs: AlbumsInteractorOutputs?

    init(outputs: AlbumsInteractorOutputs,
         artist: ArtistType,
         service: AlbumsServiceType) {

        self.outputs = outputs
        self.artist = artist
        self.service = service
    }

    deinit {
        print("['] \(type(of: self))")
    }
}

extension AlbumsInteractor: AlbumsInteractorInputs {
    func request() {
        dispose = DisposeBag()
        service.albums(fromArtist: artist)
            .mapResult()
            .subscribe(onNext: { [weak self] (result) in
                self?.outputs?.response(result)
            }).addDisposableTo(dispose)
    }
}
