//
//  PlaylistsInteractor.swift
//  FeaturePlaylist
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

/**
 Inputs declarations here (Interactor)
 */
protocol PlaylistsInteractorInputs: class {

}

/**
 Outputs declarations here (Presenter)
 */
protocol PlaylistsInteractorOutputs: class {

}

protocol PlaylistsInteractorType {
    var inputs: PlaylistsInteractorInputs { get }
    var outputs: PlaylistsInteractorOutputs? { get }
}

final class PlaylistsInteractor: PlaylistsInteractorType {
    var inputs: PlaylistsInteractorInputs { return self }
    weak var outputs: PlaylistsInteractorOutputs?

    init(outputs: PlaylistsInteractorOutputs) {
        self.outputs = outputs
        /*
         Inject additional dependencies here
         */
    }

    deinit {
        print("['] \(type(of: self))")
    }
}

extension PlaylistsInteractor: PlaylistsInteractorInputs {
    /*
     Implement PlaylistsInteractorInputs protocol
     */
}
