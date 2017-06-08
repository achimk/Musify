//
//  PlaylistsPresenter.swift
//  FeaturePlaylist
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

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
    func create(_ name: String)
    func delete(_ playlist: PlaylistType)
}

/**
 Outputs declarations here (ViewController)
 */
protocol PlaylistsPresenterOutputs: class {
    func present(_ items: Array<PlaylistPresentable>)
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
    func create(_ name: String) {
        interactor.createAndAdd(name: name)
    }

    func delete(_ playlist: PlaylistType) {
        interactor.remove(playlist: playlist)
    }
}

extension PlaylistsPresenter: PlaylistsInteractorOutputs {
    func playlists(_ result: PlaylistsResult) {
        let items = result.recover([]).map { PlaylistPresentationItem($0) }
        outputs?.present(items)
    }
}
