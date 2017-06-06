//
//  SongsInteractor.swift
//  FeatureSongs
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
protocol SongsInteractorInputs: class {
    func request()
}

/**
 Outputs declarations here (Presenter)
 */
protocol SongsInteractorOutputs: class {
    func response(_ result: SongsResult)
}

protocol SongsInteractorType {
    var inputs: SongsInteractorInputs { get }
    var outputs: SongsInteractorOutputs? { get }
}

final class SongsInteractor: SongsInteractorType {
    fileprivate let album: AlbumType
    fileprivate let service: SongsServiceType
    fileprivate var dispose = DisposeBag()

    var inputs: SongsInteractorInputs { return self }
    weak var outputs: SongsInteractorOutputs?

    init(outputs: SongsInteractorOutputs, album: AlbumType, service: SongsServiceType) {

        self.outputs = outputs
        self.album = album
        self.service = service
    }

    deinit {
        print("['] \(type(of: self))")
    }
}

extension SongsInteractor: SongsInteractorInputs {
    func request() {
        dispose = DisposeBag()
        service.songs(fromAlbum: album)
            .mapResult()
            .subscribe(onNext: { [weak self] (result) in
                self?.outputs?.response(result)
            }).addDisposableTo(dispose)
    }
}
