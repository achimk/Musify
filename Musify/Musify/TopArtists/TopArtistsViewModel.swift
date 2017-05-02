//
//  TopArtistsViewModel.swift
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

protocol TopArtistsInputs {

}

protocol TopArtistsOutputs {
    var onArtists: Driver<Array<TopArtistPresentable>> { get }
}

protocol TopArtistsViewModelType {
    var inputs: TopArtistsInputs { get }
    var outputs: TopArtistsOutputs { get }
}

struct TopArtistsViewModel: TopArtistsViewModelType {
    fileprivate let driverArtists: Driver<Array<TopArtistPresentable>>

    var inputs: TopArtistsInputs { return self }
    var outputs: TopArtistsOutputs { return self }

    init(service: ArtistsServiceType) {
        self.driverArtists = service
            .topArtists()
            .mapResult()
            .map { $0.recover([]) }
            .map { $0.map { TopArtistPresentationItem(artist: $0) as TopArtistPresentable } }
            .asDriver(onErrorDriveWith: Driver.never())
    }
}

extension TopArtistsViewModel: TopArtistsInputs {

}

extension TopArtistsViewModel: TopArtistsOutputs {
    var onArtists: Driver<Array<TopArtistPresentable>> { return driverArtists }
}
