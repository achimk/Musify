//
//  AlbumsPresenter.swift
//  FeatureAlbums
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import MusServices

protocol AlbumsPresenterAppearance {
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

/**
 Inputs declarations here (Presenter)
 */
protocol AlbumsPresenterInputs: class, AlbumsPresenterAppearance {
    func request()
    func present(album: AlbumType)
}

/**
 Outputs declarations here (ViewController)
 */
protocol AlbumsPresenterOutputs: class {
    func present(_ items: Array<AlbumPresentable>)
}

protocol AlbumsPresenterType {
    var inputs: AlbumsPresenterInputs { get }
    var outputs: AlbumsPresenterOutputs? { get }
}

final class AlbumsPresenter: AlbumsPresenterType {
    let navigator: AlbumsNavigatorType
    var interactor: AlbumsInteractorInputs!
    var inputs: AlbumsPresenterInputs { return self }
    weak var outputs: AlbumsPresenterOutputs?

    init(navigator: AlbumsNavigatorType,
         outputs: AlbumsPresenterOutputs) {

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

extension AlbumsPresenter: AlbumsPresenterAppearance {
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

extension AlbumsPresenter: AlbumsPresenterInputs {
    func request() {
        interactor.request()
    }

    func present(album: AlbumType) {
        navigator.present(album: album)
    }
}

extension AlbumsPresenter: AlbumsInteractorOutputs {
    func response(_ result: AlbumsResult) {
        let items = result.recover([]).map { AlbumPresentationItem($0) }
        outputs?.present(items)
    }
}
