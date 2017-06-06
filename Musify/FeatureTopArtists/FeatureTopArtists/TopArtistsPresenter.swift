//
//  TopArtistsPresenter.swift
//  ModuleTopArtists
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Result
import MusServices

protocol TopArtistsPresenterAppearance {
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

/**
 Inputs declarations here (Presenter)
 */
protocol TopArtistsPresenterInputs: class, TopArtistsPresenterAppearance {
    func request()
    func present(artist: ArtistType)
}

/**
 Outputs declarations here (ViewController)
 */
protocol TopArtistsPresenterOutputs: class {
    func present(_ items: Array<TopArtistPresentationItem>)
}

protocol TopArtistsPresenterType {
    var inputs: TopArtistsPresenterInputs { get }
    var outputs: TopArtistsPresenterOutputs? { get }
}

final class TopArtistsPresenter: TopArtistsPresenterType {
    let navigator: TopArtistsNavigatorType
    var interactor: TopArtistsInteractorInputs!
    var inputs: TopArtistsPresenterInputs { return self }
    weak var outputs: TopArtistsPresenterOutputs?

    init(navigator: TopArtistsNavigatorType,
         outputs: TopArtistsPresenterOutputs) {

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

extension TopArtistsPresenter: TopArtistsPresenterAppearance {
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

extension TopArtistsPresenter: TopArtistsPresenterInputs {
    func request() {
        interactor.request()
    }

    func present(artist: ArtistType) {
        navigator.present(artist: artist)
    }
}

extension TopArtistsPresenter: TopArtistsInteractorOutputs {
    func response(_ result: TopArtistsResult) {
        let items = result.recover([]).map { TopArtistPresentationItem($0) }
        outputs?.present(items)
    }
}
