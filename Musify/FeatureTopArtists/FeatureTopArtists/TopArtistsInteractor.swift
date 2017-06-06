//
//  TopArtistsInteractor.swift
//  ModuleTopArtists
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
protocol TopArtistsInteractorInputs: class {
    func request()
}

/**
 Outputs declarations here (Presenter)
 */
protocol TopArtistsInteractorOutputs: class {
    func response(_ result: TopArtistsResult)
}

protocol TopArtistsInteractorType {
    var inputs: TopArtistsInteractorInputs { get }
    var outputs: TopArtistsInteractorOutputs? { get }
}

final class TopArtistsInteractor: TopArtistsInteractorType {
    fileprivate let service: ArtistsServiceType
    fileprivate var dispose = DisposeBag()

    var inputs: TopArtistsInteractorInputs { return self }
    weak var outputs: TopArtistsInteractorOutputs?

    init(outputs: TopArtistsInteractorOutputs,
         service: ArtistsServiceType) {

        self.outputs = outputs
        self.service = service
    }

    deinit {
        print("['] \(type(of: self))")
    }
}

extension TopArtistsInteractor: TopArtistsInteractorInputs {
    func request() {
        service.topArtists()
            .mapResult()
            .subscribe(onNext: { [weak self] (result) in
                self?.outputs?.response(result)
        }).addDisposableTo(dispose)
    }
}
