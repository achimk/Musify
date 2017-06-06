//
//  PlaylistsPresenter.swift
//  FeaturePlaylist
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol PlaylistsPresenterAppearance {
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

/**
 Inputs declarations here (Presenter)
 */
protocol PlaylistsPresenterInputs: class, PlaylistsPresenterAppearance {

}

/**
 Outputs declarations here (ViewController)
 */
protocol PlaylistsPresenterOutputs: class {

}

protocol PlaylistsPresenterType {
    var inputs: PlaylistsPresenterInputs { get }
    var outputs: PlaylistsPresenterOutputs? { get }
}

final class PlaylistsPresenter: PlaylistsPresenterType {
    let navigator: PlaylistsNavigatorType
    var interactor: PlaylistsInteractorInputs!
    var inputs: PlaylistsPresenterInputs { return self }
    weak var outputs: PlaylistsPresenterOutputs?

    init(navigator: PlaylistsNavigatorType,
         outputs: PlaylistsPresenterOutputs) {

        self.navigator = navigator
        self.outputs = outputs
        /*
         Inject additional dependencies here
         */
    }

    deinit {
        print("['] \(type(of: self))")
    }
}

extension PlaylistsPresenter: PlaylistsPresenterAppearance {
    func viewDidLoad() {
    }

    func viewWillAppear(_ animated: Bool) {
    }

    func viewDidAppear(_ animated: Bool) {
    }

    func viewWillDisappear(_ animated: Bool) {
    }

    func viewDidDisappear(_ animated: Bool) {
    }
}

extension PlaylistsPresenter: PlaylistsPresenterInputs {
    /*
     Implement PlaylistsPresenterInputs protocol
     */
}

extension PlaylistsPresenter: PlaylistsInteractorOutputs {
    /*
     Implement PlaylistsInteractorOutputs protocol
     */
}
