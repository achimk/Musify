//
//  DeeplinkViewModel.swift
//  MusifyDeeplink
//
//  Created by Joachim Kret on 08/04/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DeeplinkInputs {
    func deeplink(atIndex index: Int)
}

protocol DeeplinkOutputs {
    var onDeeplinkURL: Driver<URL> { get }
    var onDeeplinks: Driver<Array<DeeplinkPresentable>> { get }
}

protocol DeeplinkViewModelType {
    var inputs: DeeplinkInputs { get }
    var outputs: DeeplinkOutputs { get }
}

struct DeeplinkViewModel: DeeplinkViewModelType {
    fileprivate let valueIndex = PublishSubject<Int>()
    fileprivate let driverDeeplinkURL: Driver<URL>
    fileprivate let driverDeeplinks: Driver<Array<DeeplinkPresentable>>

    var inputs: DeeplinkInputs { return self }
    var outputs: DeeplinkOutputs { return self }

    init(service: DeeplinkServiceType) {
        let deeplinks = service.deeplinks()

        self.driverDeeplinks = deeplinks
            .map { $0.map { DeeplinkPresentationItem($0) as DeeplinkPresentable } }
            .asDriver(onErrorDriveWith: Driver.never())

        self.driverDeeplinkURL = valueIndex.asObservable()
            .withLatestFrom(deeplinks) { (index, results) -> URL in
                return results[index].url
            }
            .asDriver(onErrorDriveWith: Driver.never())
    }
}

extension DeeplinkViewModel: DeeplinkInputs {
    func deeplink(atIndex index: Int) {
        valueIndex.onNext(index)
    }
}

extension DeeplinkViewModel: DeeplinkOutputs {
    var onDeeplinkURL: Driver<URL> { return driverDeeplinkURL }
    var onDeeplinks: Driver<Array<DeeplinkPresentable>> { return driverDeeplinks }
}
