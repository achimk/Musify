//
//  SongsPresenter.swift
//  FeatureSongs
//
//  Created by Joachim Kret on 06/06/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Result

protocol SongsPresenterAppearance {
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

/**
 Inputs declarations here (Presenter)
 */
protocol SongsPresenterInputs: class, SongsPresenterAppearance {
    func request()
}

/**
 Outputs declarations here (ViewController)
 */
protocol SongsPresenterOutputs: class {
    func present(_ items: Array<SongPresentable>)
}

protocol SongsPresenterType {
    var inputs: SongsPresenterInputs { get }
    var outputs: SongsPresenterOutputs? { get }
}

final class SongsPresenter: SongsPresenterType {
    let navigator: SongsNavigatorType
    var interactor: SongsInteractorInputs!
    var inputs: SongsPresenterInputs { return self }
    weak var outputs: SongsPresenterOutputs?

    init(navigator: SongsNavigatorType,
         outputs: SongsPresenterOutputs) {

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

extension SongsPresenter: SongsPresenterAppearance {
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

extension SongsPresenter: SongsPresenterInputs {
    func request() {
        interactor.request()
    }
}

extension SongsPresenter: SongsInteractorOutputs {
    func response(_ result: SongsResult) {
        let items = result.recover([]).map { SongPresentationItem($0) }
        outputs?.present(items)
    }
}
